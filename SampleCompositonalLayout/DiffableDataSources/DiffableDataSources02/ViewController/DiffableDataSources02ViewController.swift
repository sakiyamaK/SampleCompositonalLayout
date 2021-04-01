//
//  DiffableDataSources02ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/4/1.
//

import UIKit

final class DiffableDataSources02ViewController: UIViewController {

  enum Section: CaseIterable {
    case main
  }

  var dataSource: UICollectionViewDiffableDataSource<Section, SampleModel02>!

  @IBOutlet private weak var sortButton: UIButton!

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseId)
    }
  }
}

extension DiffableDataSources02ViewController {
  var layout: UICollectionViewLayout {
    UICollectionViewCompositionalLayout.init { (_, _) -> NSCollectionLayoutSection? in

      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
      )

      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = .init(top: 0, leading: 0, bottom: 1, trailing: 0)

      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(44)
      )

      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

      let section = NSCollectionLayoutSection(group: group)
      return section
    }
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, SampleModel02>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, sample: SampleModel02) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseId, for: indexPath) as! UICollectionViewCell
      
      return cell
    }
  }

  func performQuery(with searchWord: String) {
    let samples = SampleModel02.samples
      .filter { model -> Bool in
        guard !searchWord.isEmpty else { return true }
        return model.text.contains(searchWord)
      }.sorted { $0.text < $1.text }

    var snapshot = NSDiffableDataSourceSnapshot<Section, SampleModel02>()
    snapshot.appendSections([.main])
    snapshot.appendItems(samples)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}
