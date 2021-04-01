//
//  HomeViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/21.
//

import UIKit

final class HomeViewController: UIViewController {
  @IBAction func tapCL01(_: Any) {
    Router.shared.showCompositionalLayout01(from: self)
  }

  @IBAction func tapCL02(_: Any) {
    Router.shared.showCompositionalLayout02(from: self)
  }

  @IBAction func tapCL3(_: Any) {
    Router.shared.showCompositionalLayout03(from: self)
  }

  @IBAction func tapCL04(_: Any) {
    Router.shared.showCompositionalLayout04(from: self)
  }

  @IBAction func tapCL05(_: Any) {
    Router.shared.showCompositionalLayout05(from: self)
  }

  @IBAction func tapCL06(_: Any) {
    Router.shared.showCompositionalLayout06(from: self)
  }

  @IBAction func tapDD01(_: Any) {
    Router.shared.showDiffableDataSources01(from: self)
  }
}
