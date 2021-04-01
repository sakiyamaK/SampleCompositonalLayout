//
//  SampleModel.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/21.
//

import Foundation

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

  private static func createSampless(times0: Int, times1 _: Int) -> [[Self]] {
    Array(0 ... times0).map { _ -> [SampleModel01] in
      SampleModel01.createSamples(times: 1)
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
