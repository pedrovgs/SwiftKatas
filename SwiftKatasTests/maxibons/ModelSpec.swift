//
//  ModelSpec.swift
//  SwiftKatasTests
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation
@testable import SwiftKatas
import XCTest
import SwiftCheck

class ModelSpec: XCTestCase {

    func testDeveloperProperties() {
        property("never instantiates a developer consuming a negative amount of maxibons")
            <- forAll { (name: String, maxibonsToGrab: Int) in
                let developer = Developer(name: name, numberOfMaxibonsToGet: maxibonsToGrab)
                return developer.numberOfMaxibonsToGet >= 0 || developer.numberOfMaxibonsToGet == maxibonsToGrab
        }
    }

    func testWorldProperties() {
        property("never instantiates a KarumiFridge with less than 3 maxibons")
            <- forAll { (maxibonsLeft: Int) in
                let fridge = KarumiFridge(maxibonsLeft: maxibonsLeft)
                let configuredMaxibons = fridge.maxibonsLeft
                return configuredMaxibons > 2 || configuredMaxibons == maxibonsLeft
        }

        property("never instantiates a KarumiFridge with more than 12 maxibons")
            <- forAll { (maxibonsLeft: Int) in
                let fridge = KarumiFridge(maxibonsLeft: maxibonsLeft)
                let configuredMaxibons = fridge.maxibonsLeft
                return configuredMaxibons <= 12 || configuredMaxibons == maxibonsLeft
        }
    }
}
