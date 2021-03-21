//
//  CompositionalLayout02ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/21.
//

import UIKit

final class CompositionalLayout02ViewController: UIViewController {

    private let itemss = SampleModel01.smaple01ss

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = layout
            collectionView.register(UINib(resource: R.nib.uiCollectionViewCell01), forCellWithReuseIdentifier: UICollectionViewCell01.reuseId)
            collectionView.backgroundColor = .systemGray
        }
    }
}

private extension CompositionalLayout02ViewController {
    var layout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(5)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension CompositionalLayout02ViewController: UICollectionViewDelegate {

}

extension CompositionalLayout02ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        itemss.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemss[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell01.reuseId, for: indexPath) as! UICollectionViewCell01
        cell.configure(sample: itemss[indexPath.section][indexPath.item])
        return cell
    }
}
