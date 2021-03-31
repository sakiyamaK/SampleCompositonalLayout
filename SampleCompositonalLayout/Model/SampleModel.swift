//
//  SampleModel.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/21.
//

import Foundation

struct SampleModel01 {
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

  static var samples: [Self] {
    SampleModel01.createSamples(times: 100)
  }

  static var sampless: [[Self]] {
    createSampless(times0: 50, times1: 20)
  }

  static var smaple02ss: [[Self]] {
    [SampleModel01.createSamples(times: 5), SampleModel01.createSamples(times: 10), SampleModel01.createSamples(times: 20)]
  }
}
