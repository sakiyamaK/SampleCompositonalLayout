//
//  SampleModel.swift
//  SampleCompositonalLayout
//
//  Created by sakiyamaK on 2021/03/21.
//

import Foundation

struct SampleModel01 {
  var text: String

  static var smaple01s: [SampleModel01] {
    Array(0 ... 100).map {
      SampleModel01(text: $0.description + " desuyo")
    }
  }

  static var smaple01ss: [[SampleModel01]] {
    Array(0 ... 50).map { _ -> [SampleModel01] in
      Array(0 ... 20).map {
        SampleModel01(text: $0.description + " desuyo")
      }
    }
  }
}
