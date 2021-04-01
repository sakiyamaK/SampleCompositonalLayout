//
//  CompositionalLayout06ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/31.
//

import UIKit

final class SectionBackgroundDecorationView: UICollectionReusableView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("not implemented")
  }
}

extension SectionBackgroundDecorationView {
  func configure() {
    backgroundColor = UIColor.white.withAlphaComponent(0.5)
    layer.borderColor = UIColor.black.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 12
  }
}

final class CompositionalLayout06ViewController: UIViewController {
  private let items = SampleModel01.samples

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UINib(resource: R.nib.uiCollectionViewCell01), forCellWithReuseIdentifier: UICollectionViewCell01.reuseId)
      collectionView.register(UINib(resource: R.nib.uiCollectionHeaderView01), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UICollectionHeaderView01.reuseId)
      collectionView.backgroundColor = .systemGray
    }
  }
}

private extension CompositionalLayout06ViewController {
  var layout: UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout.init { (_, _) -> NSCollectionLayoutSection? in

      let leftFractional: CGFloat = 0.7
      let rightFractional: CGFloat = 1.0 - leftFractional

      let leadingItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(leftFractional),
                                           heightDimension: .fractionalHeight(1.0)))
      leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

      // NSCollectionLayoutGroupのsubitems,countだとheightDimensionの値は関係ないらしい
      let trailingItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalHeight(1.0)))
      trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

      let trailingGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(rightFractional),
                                           heightDimension: .fractionalHeight(1.0)),
        subitem: trailingItem, count: 2
      )

      let containerGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                           heightDimension: .fractionalHeight(0.4)),
        subitems: [leadingItem, trailingGroup]
      )

      let section = NSCollectionLayoutSection(group: containerGroup)
      section.orthogonalScrollingBehavior = .continuous
      section.interGroupSpacing = 5
      section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

      // sectionの背景をデコレーション
      let decorationItem: NSCollectionLayoutDecorationItem = .background(elementKind: SectionBackgroundDecorationView.reuseId)
      decorationItem.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

      section.decorationItems = [decorationItem]
      return section
    }

    layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: SectionBackgroundDecorationView.reuseId)
    return layout
  }
}

extension CompositionalLayout06ViewController: UICollectionViewDelegate {}

extension CompositionalLayout06ViewController: UICollectionViewDataSource {
  func numberOfSections(in _: UICollectionView) -> Int {
    return 10
  }

  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell01.reuseId, for: indexPath) as! UICollectionViewCell01
    cell.configure(sample: items[indexPath.item], cornerRadius: 8)
    return cell
  }
}
