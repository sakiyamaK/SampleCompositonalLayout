//
//  UIImageViewCell.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/04/03.
//

import UIKit

final class UIImageViewCell: UICollectionViewCell {
  @IBOutlet private var imageView: UIImageView!

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
    imageView.image = nil
  }

  func configure(sample: SampleImageModel, cornerRadius _: CGFloat = 0) {
    imageView.image = sample.image
  }
}
