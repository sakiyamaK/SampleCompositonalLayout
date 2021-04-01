//
//  IBPCollectionViewCompositionalLayoutInteroperability.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/31.
//

import IBPCollectionViewCompositionalLayout

typealias NSCollectionLayoutAnchor = IBPNSCollectionLayoutAnchor
typealias NSCollectionLayoutBoundarySupplementaryItem = IBPNSCollectionLayoutBoundarySupplementaryItem
typealias NSCollectionLayoutDecorationItem = IBPNSCollectionLayoutDecorationItem
typealias NSCollectionLayoutDimension = IBPNSCollectionLayoutDimension
typealias NSCollectionLayoutEdgeSpacing = IBPNSCollectionLayoutEdgeSpacing
typealias NSCollectionLayoutEnvironment = IBPNSCollectionLayoutEnvironment
typealias NSCollectionLayoutGroup = IBPNSCollectionLayoutGroup
typealias NSCollectionLayoutGroupCustomItem = IBPNSCollectionLayoutGroupCustomItem
typealias NSCollectionLayoutItem = IBPNSCollectionLayoutItem
typealias NSCollectionLayoutSection = IBPNSCollectionLayoutSection
typealias NSCollectionLayoutSize = IBPNSCollectionLayoutSize
typealias NSCollectionLayoutSpacing = IBPNSCollectionLayoutSpacing
typealias NSCollectionLayoutSupplementaryItem = IBPNSCollectionLayoutSupplementaryItem
typealias NSCollectionLayoutVisibleItem = IBPNSCollectionLayoutVisibleItem
typealias NSDirectionalEdgeInsets = IBPNSDirectionalEdgeInsets
typealias UICollectionLayoutSectionOrthogonalScrollingBehavior = IBPUICollectionLayoutSectionOrthogonalScrollingBehavior
typealias UICollectionViewCompositionalLayout = IBPUICollectionViewCompositionalLayout
typealias UICollectionViewCompositionalLayoutConfiguration = IBPUICollectionViewCompositionalLayoutConfiguration

public extension IBPNSDirectionalEdgeInsets {
  static var zero: IBPNSDirectionalEdgeInsets {
    return IBPNSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
  }
}
