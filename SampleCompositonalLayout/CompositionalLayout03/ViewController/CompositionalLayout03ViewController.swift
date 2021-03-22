//
//  CompositionalLayout03ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/22.
//

import UIKit

final class CompositionalLayout03ViewController: UIViewController {
  private let itemss = SampleModel01.smaple01ss

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
    // アイテムの横幅をグループの0.2倍、高さを1倍にする
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.2),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(44)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    // アイテム間の余白を最小で5にする
    group.interItemSpacing = .flexible(5)
    // グループの左右に10の余白を入れる
    group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 30
    section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)

    /*
     header footerの設定
     */
    // フッタのためにサイズを用意
    let footerHeaderSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(50.0)
    )
    // ヘッダ
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: footerHeaderSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    // フッタ
    let footer = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: footerHeaderSize,
      elementKind: UICollectionView.elementKindSectionFooter,
      alignment: .bottom
    )

    // セクションに登録
    section.boundarySupplementaryItems = [header, footer]

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
