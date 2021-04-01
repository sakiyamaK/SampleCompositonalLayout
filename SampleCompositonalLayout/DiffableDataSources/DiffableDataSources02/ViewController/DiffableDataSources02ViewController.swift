//
//  DiffableDataSources02ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/4/1.
//

import UIKit

final class DiffableDataSources02ViewController: UIViewController {
  final class SortSection: Hashable {
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: SortSection, rhs: SortSection) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private var identifier = UUID()
    var isSorted: Bool {
      currentSortIndex >= nodes.count - 1
    }

    private(set) var nodes: [SampleModel03] = []

    var currentSortIndex: Int = 1
    func create(times: Int) {
      nodes = SampleModel03.createSamples(times: times)
    }
  }

  private let columns: Int = 20
  private let rows: Int = 20

  var dataSource: UICollectionViewDiffableDataSource<SortSection, SampleModel03>!

  @IBOutlet private var sortButton: UIButton! {
    didSet {
      sortButton.addTarget(self, action: #selector(tapSortButton), for: .touchUpInside)
    }
  }

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseId)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureDataSource()
    performQuery()
  }

  @objc func tapSortButton() {
    sort()
  }
}

private extension DiffableDataSources02ViewController {
  var layout: UICollectionViewLayout {
    UICollectionViewCompositionalLayout.init { (_: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                        heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: size)

      let contentSize = layoutEnvironment.container.effectiveContentSize
      let rowHeight = contentSize.height / CGFloat(self.rows)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .absolute(rowHeight))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: self.columns)
      let section = NSCollectionLayoutSection(group: group)
      return section
    }
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<SortSection, SampleModel03>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, sample: SampleModel03) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseId, for: indexPath)
      cell.backgroundColor = sample.color
      return cell
    }
  }

  func performQuery() {
    var snapshot = NSDiffableDataSourceSnapshot<SortSection, SampleModel03>()
    for _ in 1 ... rows {
      let section = SortSection()
      section.create(times: columns)
      snapshot.appendSections([section])
      snapshot.appendItems(section.nodes)
    }
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  func sort() {
    var updateSnapshot = dataSource.snapshot()
    let isSorted = updateSnapshot.sectionIdentifiers.allSatisfy { $0.isSorted }
    guard !isSorted else {
      return
    }

    updateSnapshot.sectionIdentifiers.forEach {
      let section = $0
      var items = section.nodes

      var index = section.currentSortIndex
      let currentItem = items[index]
      index -= 1
      while index >= 0, currentItem.id < items[index].id {
        let tmp = items[index]
        items[index] = currentItem
        items[index + 1] = tmp
        index -= 1
      }

      section.currentSortIndex += 1

      updateSnapshot.deleteItems(items)
      updateSnapshot.appendItems(items, toSection: section)
    }

    dataSource.apply(updateSnapshot)

    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(125)) {
      self.sort()
    }
  }
}
