//
//  MockChat.swift
//  SwiftKatasTests
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation
import Bow
import BowEffects
@testable import SwiftKatas

class MockChat: Chat {
    typealias F = ForId

    var messageSent: Option<String> = Option.none()

    func sendMessage(message: String) -> Kind<ForId, String> {
        self.messageSent = Option.some(message)
        return Id(message)
    }

}
