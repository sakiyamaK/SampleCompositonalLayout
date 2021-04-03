//
//  CompositionalLayout08ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/4/3.
//

import UIKit

final class CompositionalLayout08ViewController: UIViewController {

  private var items: [SampleImageModel] = []

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UINib.init(nibName: UIImageViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: UIImageViewCell.reuseId)
      collectionView.backgroundColor = .systemGray
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    SampleImageModel.load(times: 50) {[unowned self] items in
      self.items = items
      self.collectionView.reloadData()
    }
  }
}

private extension CompositionalLayout08ViewController {
  var layout: UICollectionViewLayout {
    UICollectionViewCompositionalLayout { [unowned self] (section, environment) -> NSCollectionLayoutSection? in

      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(environment.container.effectiveContentSize.height)
      )

      let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { [unowned self] (environment) -> [NSCollectionLayoutGroupCustomItem] in

        var items: [NSCollectionLayoutGroupCustomItem] = []

        var layouts: [Int: CGFloat] = [:]

        let space: CGFloat = 8
        let numberOfColumn: CGFloat = 2

        let defaultSize = CGSize(width: 100, height: 100)

        for idx in (0 ..< self.collectionView.numberOfItems(inSection: section)) {

          let size = self.items[idx].image?.size ?? defaultSize
          let aspect = CGFloat(size.height) / CGFloat(size.width)

          let width = (environment.container.effectiveContentSize.width - (numberOfColumn - 1) * space) / numberOfColumn
          let height = width * aspect

          let currentColumn = idx % Int(numberOfColumn)
          let y = layouts[currentColumn] ?? 0.0 + space
          let x = width * CGFloat(currentColumn) + space * (CGFloat(currentColumn) - 1.0)

          let frame = CGRect(x: x, y: y + space, width: width, height: height)
          let item = NSCollectionLayoutGroupCustomItem(frame: frame)
          items.append(item)

          layouts[currentColumn] = frame.maxY
        }
        return items
      }
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
