//
//  DiffableDataSources01ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/4/1.
//

import UIKit

final class DiffableDataSources01ViewController: UIViewController {
  enum Section: CaseIterable {
    case main
  }

  var dataSource: UICollectionViewDiffableDataSource<Section, SampleModel02>!

  @IBOutlet private var searchBar: UISearchBar! {
    didSet {}
  }

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UINib(resource: R.nib.uiCollectionViewCell01), forCellWithReuseIdentifier: UICollectionViewCell01.reuseId)
      collectionView.backgroundColor = .systemGray
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureDataSource()
    performQuery(with: "")
  }
}

extension DiffableDataSources01ViewController {
  var layout: UICollectionViewLayout {
    UICollectionViewCompositionalLayout.init { (_, _) -> NSCollectionLayoutSection? in

      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
      )

      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = .init(top: 0, leading: 0, bottom: 1, trailing: 0)

      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(44)
      )

      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

      let section = NSCollectionLayoutSection(group: group)
      return section
    }
  }

  func configureDataSource() {
    // データソースを定義
    dataSource = UICollectionViewDiffableDataSource<Section, SampleModel02>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, sample: SampleModel02) -> UICollectionViewCell? in
      // ここでこれまでDataSoucesプロトコルでやっていたセルの構築を行う
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell01.reuseId, for: indexPath) as! UICollectionViewCell01
      cell.configure(sample: sample)
      return cell
    }
  }

  func performQuery(with searchWord: String) {
    let samples = SampleModel02.samples
      .filter { model -> Bool in
        guard !searchWord.isEmpty else { return true }
        return model.text.contains(searchWord)
      }.sorted { $0.text < $1.text }

    // 新しいsnapshotを用意する
    var snapshot = NSDiffableDataSourceSnapshot<Section, SampleModel02>()
    // セクションの数を登録する
    snapshot.appendSections([.main])
    // セルの配列を登録する
    snapshot.appendItems(samples)
    // データソースにsnapshotを適応させる
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

extension DiffableDataSources01ViewController: UISearchBarDelegate {
  func searchBar(_: UISearchBar, textDidChange searchText: String) {
    performQuery(with: searchText)
  }
}
