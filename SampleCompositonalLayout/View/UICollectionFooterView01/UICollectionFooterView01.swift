//
//  UICollectionFooterView01.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/21.
//

import UIKit

final class UICollectionFooterView01: UICollectionReusableView {
  @IBOutlet private var contentView: UIView!
  @IBOutlet private var textLabel: UILabel!

  override func prepareForReuse() {
    super.prepareForReuse()
    textLabel.text = nil
  }

  func configure(indexPath: IndexPath) {
    textLabel.text = "section footer : " + indexPath.section.description
  }
}
