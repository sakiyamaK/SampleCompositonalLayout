//
//  CompositionalLayout03ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/22.
//

import UIKit

final class CompositionalLayout03ViewController: UIViewController {
  private let itemss = SampleModel01.sampless

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UINib(resource: R.nib.uiCollectionViewCell01), forCellWithReuseIdentifier: UICollectionViewCell01.reuseId)
      collectionView.backgroundColor = .systemGray

      collectionView.register(UINib(resource: R.nib.uiCollectionHeaderView01), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UICollectionHeaderView01.reuseId)

      collectionView.register(UINib(resource: R.nib.uiCollectionFooterView01), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UICollectionFooterView01.reuseId)
    }
  }
}

private extension CompositionalLayout03ViewController {
  var layout: UICollectionViewLayout {
    let leftFractional: CGFloat = 0.7
    let rightFractional: CGFloat = 1.0 - leftFractional
    // 左側のアイテム
    let leadingItem = NSCollectionLayoutItem(
      // グループに対する比率
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(leftFractional),
                                         heightDimension: .fractionalHeight(1.0))
    )
    // 余白
    leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    // 右側
    let trailingItem = NSCollectionLayoutItem(
      // グループに対する比率 NSCollectionLayoutGroupがsubitem指定だと関係ない
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                         heightDimension: .fractionalHeight(1.0))
    )
    // 余白
    trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    // 右側のアイテムグループ　縦並びにするからvertical
    let trailingGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(rightFractional),
                                         heightDimension: .fractionalHeight(1.0)),
      // 同じitemを2回繰り返す時はこんな感じ
      subitem: trailingItem,
      count: 2
      // こうでも同じitemを2回繰り返せる
//      subitems: [trailingItem, trailingItem]
    )

    // sectionに入れる大元となるグループ
    let nestedGroup = NSCollectionLayoutGroup.horizontal(
      // colelctionviewに対する比率
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                         heightDimension: .fractionalHeight(0.4)),
      // 右側はネストされたグループを入れる
      subitems: [leadingItem, trailingGroup]
    )

    let section = NSCollectionLayoutSection(group: nestedGroup)

    let layout = UICollectionViewCompositionalLayout(section: section)

    return layout
  }
}

extension CompositionalLayout03ViewController: UICollectionViewDelegate {}

extension CompositionalLayout03ViewController: UICollectionViewDataSource {
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

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionHeaderView01.reuseId, for: indexPath) as! UICollectionHeaderView01
      view.configure(indexPath: indexPath)
      return view
    default:
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionFooterView01.reuseId, for: indexPath) as! UICollectionFooterView01
      view.configure(indexPath: indexPath)
      return view
    }
  }
}
