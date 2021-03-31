//
//  CompositionalLayout04ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/29.
//

import UIKit

final class CompositionalLayout04ViewController: UIViewController {

  private let itemss = SampleModel01.smaple02ss

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UINib(resource: R.nib.uiCollectionViewCell01), forCellWithReuseIdentifier: UICollectionViewCell01.reuseId)
      collectionView.backgroundColor = .systemGray
    }
  }
}

private extension CompositionalLayout04ViewController {

  enum SectionLayoutKind: Int, CaseIterable {
    case list, grid5, grid3
    var columnCount: Int {
      switch self {
      case .list: return 1
      case .grid3: return 3
      case .grid5: return 5
      }
    }
  }
  var layout: UICollectionViewLayout {
    // sectionごとにレイアウトを変えるときは
    // UICollectionViewCompositionalLayout.init(sectionProvider: )を使う
    UICollectionViewCompositionalLayout.init { (sectionIndex, _) -> NSCollectionLayoutSection? in
      guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
      let columns = sectionLayoutKind.columnCount

      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

      let groupHeight = columns == 1 ?
        NSCollectionLayoutDimension.absolute(44) :
        NSCollectionLayoutDimension.fractionalWidth(0.2)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: groupHeight)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

      return section
    }
  }
}

extension CompositionalLayout04ViewController: UICollectionViewDelegate {}

extension CompositionalLayout04ViewController: UICollectionViewDataSource {
  func numberOfSections(in _: UICollectionView) -> Int {
    itemss.count
  }

  func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    itemss[section].count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell01.reuseId, for: indexPath) as! UICollectionViewCell01
    cell.configure(sample: itemss[indexPath.section][indexPath.item])
    return cell
  }
}
