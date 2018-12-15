//
//  model.swift
//  SwiftKatas
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation
import BowOptics

public struct Developer {

    public let name: String
    public let numberOfMaxibonsToGet: Int

    init(name: String, numberOfMaxibonsToGet: Int) {
        self.name = name
        self.numberOfMaxibonsToGet = numberOfMaxibonsToGet < 0 ? 0 : numberOfMaxibonsToGet
    }

}

extension World {
    static let _maxibonsLeft: Lens<World, Int> = World._karumiFridge.compose(KarumiFridge._maxibonsLeft)

    static var _karumiFridge: Lens<World, KarumiFridge> {
        return Lens(get: {
            return $0.karumiFridge
        }, set: { (_, newFridge) in
            return World(karumiFridge: newFridge)
        })
    }
}
public struct World {
    public let karumiFridge: KarumiFridge
}

extension KarumiFridge {
    static var _maxibonsLeft: Lens<KarumiFridge, Int> {
        return Lens(get: {
            return $0.maxibonsLeft
        }, set: { (_, newValue) in
            return KarumiFridge(maxibonsLeft: newValue)
        })
    }
}
public struct KarumiFridge {
    public let maxibonsLeft: Int

    init(maxibonsLeft: Int = 10) {
        self.maxibonsLeft = min(12, max(3, maxibonsLeft))
    }
}

open class Karumies {
    public static let pedro   = Developer(name: "Pedro", numberOfMaxibonsToGet: 3)
    public static let sergio  = Developer(name: "Sergio Gutierrez", numberOfMaxibonsToGet: 2)
    public static let tylos   = Developer(name: "Tylos", numberOfMaxibonsToGet: 1)
    public static let juanjo  = Developer(name: "Juanjo", numberOfMaxibonsToGet: 0)
    public static let sarroyo = Developer(name: "Sergio Arroyo", numberOfMaxibonsToGet: 5)
    public static let manolo  = Developer(name: "Manolo", numberOfMaxibonsToGet: 1)
}
