//
//  ChatModule.swift
//  SwiftKatas
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation
import Bow
import BowEffects

class ChatModule: Chat {
    typealias F = ForIO

    func sendMessage(message: String) -> Kind<ForIO, String> {
        return IO.invoke{
            print(message)
            return message
        }
    }

}
