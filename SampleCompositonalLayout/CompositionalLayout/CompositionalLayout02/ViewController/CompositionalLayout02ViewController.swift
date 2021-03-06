//
//  CompositionalLayout02ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/21.
//

import IBPCollectionViewCompositionalLayout
import UIKit

final class CompositionalLayout02ViewController: UIViewController {
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

private extension CompositionalLayout02ViewController {
  var layout: UICollectionViewLayout {
    // アイテムの横幅を親の0.2倍、高さを1倍にする
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.2),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    // グループの横幅を親の1.0倍,高さを55にする
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(55.0)
    )
    // 水平配置のグループを作成
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    // アイテム間の余白を最小で5にする
    group.interItemSpacing = .flexible(5)
    // グループの左右に10の余白を入れる
    group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)

    // セクションを作成
    let section = NSCollectionLayoutSection(group: group)
    // グループ間の余白を設定
    section.interGroupSpacing = 30
    // sectionの上下に余白を設定
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

extension CompositionalLayout02ViewController: UICollectionViewDelegate {}

extension CompositionalLayout02ViewController: UICollectionViewDataSource {
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
