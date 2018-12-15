//
//  model.swift
//  SwiftKatas
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation

public struct Developer {

    public let name: String
    public let numberOfMaxibonsToGet: Int

    init(name: String, numberOfMaxibonsToGet: Int) {
        self.name = name
        self.numberOfMaxibonsToGet = numberOfMaxibonsToGet < 0 ? 0 : numberOfMaxibonsToGet
    }

}

public struct World {
    public let karumiFridge: KarumiFridge
}

public struct KarumiFridge {
    public let maxibonsLeft: Int

    init(maxibonsLeft: Int = 10) {
        self.maxibonsLeft = max(0, maxibonsLeft)
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
