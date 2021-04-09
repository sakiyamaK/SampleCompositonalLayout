//
//  AppStoreFullImageCell.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/04/09.
//

import SnapKit
import UIKit

final class AppStoreFullImageView: UIView {
  @IBOutlet private var backgroundImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = 10
    clipsToBounds = true
    layer.shadowOffset = CGSize(width: 10, height: 10)
    layer.shadowRadius = 10
  }

  func reset() {
    backgroundImageView.image = nil
  }

  func configure(sample: SampleImageModel) {
    backgroundImageView.image = sample.image
  }
}

final class AppStoreFullImageCell: UICollectionViewCell {
  private lazy var mainView: AppStoreFullImageView! =
    UINib(nibName: "AppStoreFullImageView", bundle: nil).instantiate(withOwner: self, options: nil).first as? AppStoreFullImageView
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(mainView)
    mainView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    mainView.reset()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(sample: SampleImageModel) {
    mainView.configure(sample: sample)
  }
}
