//
//  CompositionalLayout08ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/4/3.
//

import UIKit

final class CompositionalLayout08ViewController: UIViewController {
  private var items: [SampleImageModel] = []

  @IBOutlet var segmentControll: UISegmentedControl! {
    didSet {
      segmentControll.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
    }
  }

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UINib(nibName: UIImageViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: UIImageViewCell.reuseId)
      collectionView.backgroundColor = .systemGray
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    SampleImageModel.load(times: 50) { [unowned self] items in
      self.items = items
      self.collectionView.reloadData()
    }
  }

  @objc func changeSegment() {
    updateLayout()
  }
}

private extension CompositionalLayout08ViewController {
  func updateLayout() {
    collectionView.collectionViewLayout = layout
    collectionView.alpha = 0.0
    collectionView.reloadData()
    UIView.animate(withDuration: 0.5, animations: {
      self.collectionView.alpha = 1.0
    })
  }

  var layout: UICollectionViewLayout {
    UICollectionViewCompositionalLayout { [unowned self] (section, environment) -> NSCollectionLayoutSection? in

      let layoutSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(environment.container.effectiveContentSize.height)
      )

      let group = NSCollectionLayoutGroup.custom(layoutSize: layoutSize) { [unowned self] (environment) -> [NSCollectionLayoutGroupCustomItem] in

        let horizontalSpace: CGFloat = 8
        let verticalSpace: CGFloat = 8
        let numberOfColumn: CGFloat = self.segmentControll.selectedSegmentIndex == 0 ? 1.0 : 2.0

        // 各列の最後のitemのmaxYを保存
        var itemMaxYPerColumns: [Int: CGFloat] = Dictionary(
          uniqueKeysWithValues: (0 ..< Int(numberOfColumn)).map { ($0, 0) }
        )

        let width = (environment.container.effectiveContentSize.width - (numberOfColumn - 1) * horizontalSpace) / numberOfColumn

        var items: [NSCollectionLayoutGroupCustomItem] = []

        for idx in 0 ..< self.collectionView.numberOfItems(inSection: section) {
          let size = self.items[idx].image?.size ?? .zero
          let aspect = CGFloat(size.height) / CGFloat(size.width)
          let height = width * aspect

          let currentColumn = idx % Int(numberOfColumn)
          let currentRow = idx / Int(numberOfColumn)
          let preItemMaxY = (itemMaxYPerColumns[currentColumn] ?? 0.0)
          let y = preItemMaxY + (currentRow == 0 ? 0.0 : verticalSpace)
          let x = environment.container.contentInsets.leading + width * CGFloat(currentColumn) + horizontalSpace * CGFloat(currentColumn)

          let frame = CGRect(x: x, y: y, width: width, height: height)
          let item = NSCollectionLayoutGroupCustomItem(frame: frame)
          items.append(item)

          itemMaxYPerColumns[currentColumn] = frame.maxY
        }
        return items
      }
      // なぜかtopとbottomが反応しない
      group.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
      let section = NSCollectionLayoutSection(group: group)
      // groupのcontentInsetsのtopとbottomが反応しないのでsectionで対応
      section.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 0)
      return section
    }
  }
}

extension CompositionalLayout08ViewController: UICollectionViewDelegate {}

extension CompositionalLayout08ViewController: UICollectionViewDataSource {
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIImageViewCell.reuseId, for: indexPath) as! UIImageViewCell
    let item = items[indexPath.item]
    cell.configure(sample: item)
    return cell
  }
}
