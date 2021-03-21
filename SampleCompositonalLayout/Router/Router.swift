//
//  Router.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/01/16.
//

import UIKit

/**
 画面遷移を管理
 */
final class Router {

    static let shared = Router()
    private init() { }

    private var window: UIWindow?
    // MARK: static method

    /**
     起動直後の画面を表示する
     - parameter window: UIWindow
     */
    func showRoot(window: UIWindow?) {
        let vc = R.storyboard.home.homeViewController()!
        let rootVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        self.window = window
    }

    func showCompositionalLayout01(from: UIViewController) {
        let vc = R.storyboard.compositionalLayout01.compositionalLayout01ViewController()!
        show(from: from, to: vc)
    }

    func showCompositionalLayout02(from: UIViewController) {
        let vc = R.storyboard.compositionalLayout02.compositionalLayout02ViewController()!
        show(from: from, to: vc)
    }
}

private extension Router {
    func show(from: UIViewController, to: UIViewController) {
        if let nav = from.navigationController {
            nav.pushViewController(to, animated: true)
        } else {
            from.present(to, animated: true, completion: nil)
        }
    }
}