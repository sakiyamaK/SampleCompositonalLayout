//
//  UICollectionViewCell01.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/21.
//

import UIKit

final class UICollectionViewCell01: UICollectionViewCell {

    @IBOutlet private weak var textLabel: UILabel!

    func configure(sample: SampleModel01) {
        textLabel.text = sample.text
    }
}
