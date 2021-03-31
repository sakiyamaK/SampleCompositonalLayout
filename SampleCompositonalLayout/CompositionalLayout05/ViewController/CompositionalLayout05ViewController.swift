//
//  CompositionalLayout05ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/31.
//

import UIKit

final class CompositionalLayout05ViewController: UIViewController {

  private let items = SampleModel01.samples

  enum SectionKind: Int, CaseIterable {
    case continuous, groupPaging, none, continuousGroupLeadingBoundary, paging, groupPagingCentered
    var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
      switch self {
      case .none:
        return .none
      case .continuous:
        return .continuous
      case .continuousGroupLeadingBoundary:
        return .continuousGroupLeadingBoundary
      case .paging:
        return .paging
      case .groupPaging:
        return .groupPaging
      case .groupPagingCentered:
        return .groupPagingCentered
      }
    }
  }

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UINib(resource: R.nib.uiCollectionViewCell01), forCellWithReuseIdentifier: UICollectionViewCell01.reuseId)
      collectionView.register(UINib(resource: R.nib.uiCollectionHeaderView01), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UICollectionHeaderView01.reuseId)
      collectionView.backgroundColor = .systemGray
    }
  }
}

private extension CompositionalLayout05ViewController {
  var layout: UICollectionViewLayout {
    UICollectionViewCompositionalLayout.init { (sectionIndex, _) -> NSCollectionLayoutSection? in

      let leftFractional: CGFloat = 0.7
      let rightFractional: CGFloat = 1.0 - leftFractional

      let leadingItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(leftFractional),
                                           heightDimension: .fractionalHeight(1.0)))
      leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

      //NSCollectionLayoutGroupのsubitems,countだとheightDimensionの値は関係ないらしい
      let trailingItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalHeight(1.0)))
      trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

      let trailingGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(rightFractional),
                                           heightDimension: .fractionalHeight(1.0)),
        subitem: trailingItem, count: 2)

      //横幅0.85にして横スクロールできることが分かるように次のグループをチラ見せしてる
      //縦幅0.4にして縦スクロールできることが分かるように次のセクションをチラ見せしてる
      let containerGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                           heightDimension: .fractionalHeight(0.4)),
        subitems: [leadingItem, trailingGroup])

      let section = NSCollectionLayoutSection(group: containerGroup)
      //横スクロールの設定
      let sectionKind = SectionKind(rawValue: sectionIndex)!
      section.orthogonalScrollingBehavior = sectionKind.orthogonalScrollingBehavior

      let header = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                          heightDimension: .absolute(20)),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .top
      )
      // セクションに登録
      section.boundarySupplementaryItems = [header]

      return section

    }
  }
}

extension CompositionalLayout05ViewController: UICollectionViewDelegate {}

extension CompositionalLayout05ViewController: UICollectionViewDataSource {
  func numberOfSections(in _: UICollectionView) -> Int {
    SectionKind.allCases.count
  }

  func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell01.reuseId, for: indexPath) as! UICollectionViewCell01
    cell.configure(sample: items[indexPath.item], cornerRadius: 8)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionHeaderView01.reuseId, for: indexPath) as! UICollectionHeaderView01
    let sectionKind = SectionKind(rawValue: indexPath.section)!
    view.configure(text: "." + String(describing: sectionKind))
    return view
  }
}
