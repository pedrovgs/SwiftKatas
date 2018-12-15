//
//  algebra.swift
//  SwiftKatas
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation
import Bow

public protocol Chat {
    associatedtype F

    func sendMessage(message: String) -> Kind<F, String>
}
