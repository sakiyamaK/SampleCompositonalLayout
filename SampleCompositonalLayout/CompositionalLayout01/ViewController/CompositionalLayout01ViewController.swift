//
//  CompositionalLayout01ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/21.
//

import IBPCollectionViewCompositionalLayout
import UIKit

final class CompositionalLayout01ViewController: UIViewController {
  private let items = SampleModel01.smaple01s

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UINib(resource: R.nib.uiCollectionViewCell01), forCellWithReuseIdentifier: UICollectionViewCell01.reuseId)
      collectionView.backgroundColor = .systemGray
    }
  }
}

private extension CompositionalLayout01ViewController {
  var layout: UICollectionViewLayout {
    // アイテム(セル)の大きさをグループの大きさと同じにする
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    // アイテム設定に大きさを登録してインスタンスを作る
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    // グループサイズの横幅をコレクションビューの横幅と同じ、高さを44にる
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
    // グループの水平設定に大きさとアイテムの種類を登録する
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    // セクションにグループを登録する
    let section = NSCollectionLayoutSection(group: group)

    // レイアウトにセクションを登録する
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
}

extension CompositionalLayout01ViewController: UICollectionViewDelegate {}

extension CompositionalLayout01ViewController: UICollectionViewDataSource {
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell01.reuseId, for: indexPath) as! UICollectionViewCell01
    cell.configure(sample: items[indexPath.item])
    return cell
  }
}
