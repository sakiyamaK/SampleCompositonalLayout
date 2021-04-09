//
//  AppStoreRouter.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/04/07.
//

import UIKit

extension Router {
  func showAppStoreTop(from: UIViewController) {
    let vc = R.storyboard.appStoreTop.appStoreTopViewController()!
    show(from: from, to: vc)
  }

  func showAppStoreDetail(from: UIViewController) {
    let vc = R.storyboard.appStoreDetail.appStoreDetailViewController()!
    show(from: from, to: vc)
  }
}
