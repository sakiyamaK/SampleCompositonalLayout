//
//  UICollectionViewCell01.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/21.
//

import UIKit

final class UICollectionViewCell01: UICollectionViewCell {
  @IBOutlet private var textLabel: UILabel!

  var cornerRadius: CGFloat = 0 {
    didSet {
      contentView.layer.cornerRadius = cornerRadius
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.clipsToBounds = true
    contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    textLabel.text = nil
  }

  func configure(sample: SampleModel, cornerRadius: CGFloat = 0) {
    textLabel.text = sample.text
    self.cornerRadius = cornerRadius
  }
}
