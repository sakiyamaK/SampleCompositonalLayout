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
}

struct SampleImageModel2: Hashable {
  var image: UIImage?
  var subImage: UIImage?

  static func load(times: Int = 10, completion: (([Self]) -> Void)? = nil) {
    var rtn: [Self] = []
    (1 ... times).forEach { _ in
      let mainURL = URL(string: "https://picsum.photos/200/300?\(UUID().description)")!
      KingfisherManager.shared.retrieveImage(with: mainURL) { mainResult in
        switch mainResult {
        case let .success(mainSuccess):
          let subURL = URL(string: "https://picsum.photos/50/50?\(UUID().description)")!
          KingfisherManager.shared.retrieveImage(with: subURL) { subResult in
            switch subResult {
            case let .success(subSuccess):
              rtn.append(Self(image: mainSuccess.image, subImage: subSuccess.image))
              if rtn.count == times {
                completion?(rtn)
              }
            case .failure:
              fatalError()
            }
          }
        case .failure:
          fatalError()
        }
      }
    }
  }
}
