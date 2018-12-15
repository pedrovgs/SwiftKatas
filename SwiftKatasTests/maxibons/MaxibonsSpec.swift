//
//  MaxibonsSpec.swift
//  SwiftKatasTests
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation
import XCTest
import SwiftCheck
import Bow
import BowEffects
import Nimble
@testable import SwiftKatas

class MaxibonsSpec: XCTestCase {

    func testKarumiHQsProperties() {
        property("always have more than 2 maxibons") <- forAll { (world: World, developer: Developer) in
            self.openFridge(world, developer).karumiFridge.maxibonsLeft > 2
        }

        property("always have more than 2 maxibons even if they go in groups") <-
            forAll { (world: World, developers: [Developer]) in
            self.openFridge(world, developers).karumiFridge.maxibonsLeft > 2
        }

        property("ask for more maxibons using the chat client if we need to refill") <-
            forAll(Developer.arbitraryHungry) { (developer: Developer) in
            let initialWorld = World(karumiFridge: KarumiFridge())
            let messageSent = self.openFridgeAndGetChatMessageSent(initialWorld, developer)
            return messageSent == Option.some("Hi there! I'm \(developer.name). We need more maxibons")
        }

        property("not ask for more maxibons using the chat client if we don't need to refill") <-
            forAll(Developer.arbitraryNotSoHungry) { (developer: Developer) in
            let initialWorld = World(karumiFridge: KarumiFridge())
            let messageSent = self.openFridgeAndGetChatMessageSent(initialWorld, developer)
            return messageSent == Option.none()
        }
    }

    func testLeftTheOfficeWith6MaxibonsIfPedroAndManoloGoToTheFridge() {
        let initialWorld = World(karumiFridge: KarumiFridge())
        let developers = [Karumies.pedro, Karumies.manolo]
        let finalWorld = openFridge(initialWorld, developers)
        XCTAssertEqual(finalWorld.karumiFridge.maxibonsLeft, 6)
    }

    func testUse2AsMinNumberOfMaxibons() {
        expect(KarumiHQs<ForIO>().minNumberOfMaxibons).to(be(2))
    }

    func testUse10AsNumberOfMaxibonsToRefillWhenNeeded() {
        expect(KarumiHQs<ForIO>().maxibonsToRefill).to(be(10))
    }

    private func openFridge(_ world: World, _ developer: Developer) -> World {
        return openFridge(world, [developer])
    }

    private func openFridge(_ world: World, _ developers: [Developer]) -> World {
        let karumiHQs = KarumiHQs<ForIO>()
        let finalWorld = try! karumiHQs.openFridge(ChatModule(), IO<World>.monad(),
                                                   world: world, developers: developers).fix().unsafePerformIO()
        return finalWorld
    }

    private func openFridgeAndGetChatMessageSent(_ world: World, _ developer: Developer) -> Option<String> {
        let karumiHQs = KarumiHQs<ForId>()
        let chat = MockChat()
        _ = karumiHQs.openFridge(chat, Id<World>.monad(), world: world, developer: developer).fix()
        return chat.messageSent
    }
}
