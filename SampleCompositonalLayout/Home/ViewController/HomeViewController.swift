//
//  HomeViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/21.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBAction func tapButton01(_ sender: Any) {
        Router.shared.showCompositionalLayout01(from: self)
    }
    @IBAction func tapButton02(_ sender: Any) {
        Router.shared.showCompositionalLayout02(from: self)
    }

}
