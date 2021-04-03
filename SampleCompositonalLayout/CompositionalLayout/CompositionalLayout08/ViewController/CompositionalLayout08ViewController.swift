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
    UIView.animate(withDuration: 0.25, animations: {
      self.collectionView.alpha = 1.0
    })
  }

  var layout: UICollectionViewLayout {
    UICollectionViewCompositionalLayout { [unowned self] (section, environment) -> NSCollectionLayoutSection? in

      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(environment.container.effectiveContentSize.height)
      )

      let groupInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
      let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { [unowned self] (environment) -> [NSCollectionLayoutGroupCustomItem] in

        var items: [NSCollectionLayoutGroupCustomItem] = []

        var layouts: [Int: CGFloat] = [:]

        let horizontalSpace: CGFloat = 8
        let verticalSpace: CGFloat = 8
        let numberOfColumn: CGFloat = self.segmentControll.selectedSegmentIndex == 0 ? 1.0 : 2.0

        let defaultSize = CGSize(width: 100, height: 100)

        for idx in 0 ..< self.collectionView.numberOfItems(inSection: section) {
          let size = self.items[idx].image?.size ?? defaultSize
          let aspect = CGFloat(size.height) / CGFloat(size.width)

          let width = (environment.container.effectiveContentSize.width - (numberOfColumn - 1) * horizontalSpace) / numberOfColumn - (groupInsets.leading + groupInsets.trailing)
          let height = width * aspect

          let currentColumn = idx % Int(numberOfColumn)
          let y = layouts[currentColumn] ?? 0.0 + verticalSpace
          let x = width * CGFloat(currentColumn) + horizontalSpace * (CGFloat(currentColumn) + 1) + groupInsets.leading

          let frame = CGRect(x: x, y: y + verticalSpace, width: width, height: height)
          let item = NSCollectionLayoutGroupCustomItem(frame: frame)
          items.append(item)

          layouts[currentColumn] = frame.maxY
        }
        return items
      }
      group.contentInsets = groupInsets

      return NSCollectionLayoutSection(group: group)
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
