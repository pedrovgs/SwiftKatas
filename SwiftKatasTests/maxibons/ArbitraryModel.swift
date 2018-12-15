//
//  ArbitraryModel.swift
//  SwiftKatasTests
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import SwiftKatas

extension Developer: Arbitrary {

    public static var arbitrary: Gen<Developer> {
        return Int.arbitrary.map {
            let name = String.arbitrary.generate
            return Developer(name: name, numberOfMaxibonsToGet: $0)
        }
    }

    public static var arbitraryHungry: Gen<Developer> {
        return Gen<Int>.fromElements(in: 8...Int.max).map {
            let name = String.arbitrary.generate
            return Developer(name: name, numberOfMaxibonsToGet: $0)
        }
    }

    public static var arbitraryNotSoHungry: Gen<Developer> {
        return Gen<Int>.fromElements(in: 0...7).map {
            let name = String.arbitrary.generate
            return Developer(name: name, numberOfMaxibonsToGet: $0)
        }
    }
}

extension World: Arbitrary {

    public static var arbitrary: Gen<World> {
        return Int.arbitrary.map {
            return World(karumiFridge: KarumiFridge(maxibonsLeft: $0))
        }
    }
}
