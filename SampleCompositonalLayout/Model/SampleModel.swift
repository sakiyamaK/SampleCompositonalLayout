//
//  SampleModel.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/21.
//

import Kingfisher
import UIKit

protocol SampleModel {
  var text: String { get }
}

struct SampleModel01: SampleModel {
  var text: String

  private static func createSamples(times: Int) -> [Self] {
    Array(0 ... times).map {
      SampleModel01(text: $0.description + " desuyo")
    }
  }

  private static func createSampless(times0: Int, times1: Int) -> [[Self]] {
    Array(0 ... times0).map { _ -> [SampleModel01] in
      SampleModel01.createSamples(times: times1)
    }
  }

  static var samples: [Self] { Self.createSamples(times: 100) }
  static var sampless: [[Self]] { createSampless(times0: 50, times1: 20) }
  static var smaple02ss: [[Self]] {
    [Self.createSamples(times: 5), Self.createSamples(times: 10), Self.createSamples(times: 20)]
  }
}

struct SampleModel02: SampleModel, Hashable {
  var text: String

  let identifier = UUID()
  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private static func createSamples(times: Int) -> [Self] {
    Array(0 ... times).map {
      Self(text: $0.description + " desuyo")
    }
  }

  private static func createSampless(times0: Int, times1 _: Int) -> [[Self]] {
    Array(0 ... times0).map { _ -> [Self] in
      Self.createSamples(times: 1)
    }
  }

  static var samples: [Self] {
    Self.createSamples(times: 100)
  }

  static var sampless: [[Self]] {
    createSampless(times0: 50, times1: 20)
  }

  static var smaple02ss: [[Self]] {
    [Self.createSamples(times: 5), Self.createSamples(times: 10), Self.createSamples(times: 20)]
  }
}

struct SampleModel03: Hashable, Comparable {
  private(set) var color: UIColor
  private(set) var id: Int

  let identifier = UUID()
  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.id < rhs.id
  }

  static func createSamples(times: Int) -> [Self] {
    Array(1 ... times).map { v -> Self in
      let c = UIColor(hue: CGFloat(v) / CGFloat(times), saturation: 1.0, brightness: 1.0, alpha: 1.0)
      return Self(color: c, id: v)
    }.shuffled()
  }
}

struct SampleImageModel: Hashable {
  var image: UIImage?

  static func load(times: Int = 10, completion: (([SampleImageModel]) -> Void)? = nil) {
    var rtn: [SampleImageModel] = []
    (1 ... times).forEach { _ in
      let height = 100 * Int.random(in: 1 ... 3)
      let uuid = UUID().description
      let url = URL(string: "https://picsum.photos/200/\(height)?\(uuid)")!
      let iv = UIImageView()
      iv.kf.setImage(with: url) { _ in
        rtn.append(SampleImageModel(image: iv.image))
        if rtn.count == times {
          completion?(rtn)
        }
      }
    }
  }
  //  static var samples: [SampleImageModel] {
  //    [
  //      "https://img.game8.jp/4079512/124168df8992456d61a26ecb225c3131.jpeg/show",
  //      "https://img.game8.jp/4079343/74803d79ea9ee6028db6f1872ac8b75b.jpeg/show",
  //      "https://img.game8.jp/4079420/75fa8940344f1a320491bc4ab7cdadb5.jpeg/show",
  //      "https://img.game8.jp/4079530/f1a3f42513907a1812a7f65b979983b7.jpeg/show",
  //      "https://img.game8.jp/4079253/4e134697974a97018a41730c98829879.jpeg/show",
  //      "https://img.game8.jp/4079455/4ebba56ad565f194527d3de90d200dcb.jpeg/show",
  //      "https://img.game8.jp/4079262/ec485056ab19873218424c7551fd0c30.jpeg/show",
  //      "https://img.game8.jp/4079203/29b15f6250d697575487be2efd8ea6d6.jpeg/show",
  //      "https://img.game8.jp/4079320/28aa8b493fa517507f71e24fcf3aba2e.jpeg/show",
  //      "https://img.game8.jp/4079279/f66aecaf66fbbbbe269f5fd15ed8f916.jpeg/show",
  //      "https://img.game8.jp/4079542/b912e352c4f15f94040ebd7e1187fa25.jpeg/show",
  //      "https://img.game8.jp/4079361/ece62634e95b029f0b362b2135874994.jpeg/show",
  //      "https://img.game8.jp/4079615/75fac4eaaaae9663274d54b6ed156f53.jpeg/show",
  //      "https://img.game8.jp/4079475/5d58f5fc297b3fe9ed1cde57708dbdf4.jpeg/show"
  //    ].shuffled().map { SampleImageModel(text: $0) }
  //  }
}
