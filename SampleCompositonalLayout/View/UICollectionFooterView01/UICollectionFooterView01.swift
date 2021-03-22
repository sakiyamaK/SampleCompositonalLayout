//
//  UICollectionFooterView01.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/21.
//

import UIKit

final class UICollectionFooterView01: UICollectionReusableView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var textLabel: UILabel!

    func configure(indexPath: IndexPath) {
        textLabel.text = "section footer : " + indexPath.section.description
    }
}
