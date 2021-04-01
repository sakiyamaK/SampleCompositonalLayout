//
//  DiffableDataSources01ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/4/1.
//

import UIKit

final class DiffableDataSources01ViewController: UIViewController {

  @IBOutlet private weak var searchBar: UISearchBar! {
    didSet {

    }
  }

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      
    }
  }
}

extension DiffableDataSources01ViewController: UICollectionViewDelegate {}

extension DiffableDataSources01ViewController: UICollectionViewDataSource {
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    0
  }

  func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
    UICollectionViewCell()
  }
}
