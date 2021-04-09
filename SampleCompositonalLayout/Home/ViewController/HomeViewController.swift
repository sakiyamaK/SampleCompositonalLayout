//
//  HomeViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/3/21.
//

import SnapKit
import UIKit

final class HomeViewController: UIViewController {
  @IBOutlet private var stackView: UIStackView!

  enum SegueButton: String, CaseIterable {
    case AppStore
    case CompositionalLayout01
    case CompositionalLayout02
    case CompositionalLayout03
    case CompositionalLayout04
    case CompositionalLayout05
    case CompositionalLayout06
    case CompositionalLayout07
    case CompositionalLayout08
    case DiffableDataSources01
    case DiffableDataSources02

    var button: UIButton {
      let button = UIButton()
      button.setTitle(rawValue, for: .normal)
      button.setTitleColor(.systemBlue, for: .normal)
      button.snp.makeConstraints {
        $0.height.equalTo(80)
      }
      return button
    }

    static func showNextViewController(title: String, from: UIViewController) {
      switch SegueButton(rawValue: title)! {
      case .CompositionalLayout01:
        Router.shared.showCompositionalLayout01(from: from)
      case .CompositionalLayout02:
        Router.shared.showCompositionalLayout02(from: from)
      case .CompositionalLayout03:
        Router.shared.showCompositionalLayout03(from: from)
      case .CompositionalLayout04:
        Router.shared.showCompositionalLayout04(from: from)
      case .CompositionalLayout05:
        Router.shared.showCompositionalLayout05(from: from)
      case .CompositionalLayout06:
        Router.shared.showCompositionalLayout06(from: from)
      case .CompositionalLayout07:
        Router.shared.showCompositionalLayout07(from: from)
      case .CompositionalLayout08:
        Router.shared.showCompositionalLayout08(from: from)
      case .DiffableDataSources01:
        Router.shared.showDiffableDataSources01(from: from)
      case .DiffableDataSources02:
        Router.shared.showDiffableDataSources02(from: from)
      case .AppStore:
        Router.shared.showAppStoreTop(from: from)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    for segueButton in SegueButton.allCases {
      let button = segueButton.button
      stackView.addArrangedSubview(button)
      button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
  }

  @objc func tapButton(sender: UIButton) {
    guard let title = sender.titleLabel?.text else { return }
    SegueButton.showNextViewController(title: title, from: self)
  }
}
