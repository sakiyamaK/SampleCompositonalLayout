//
//  AppStoreDetailViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/4/7.
//

import UIKit

final class AppStoreDetailViewController: UIViewController {
  @IBOutlet private var collectionView: UICollectionView! {
    didSet {}
  }
}

extension AppStoreDetailViewController: UICollectionViewDelegate {}

extension AppStoreDetailViewController: UICollectionViewDataSource {
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    0
  }

  func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
    UICollectionViewCell()
  }
}
