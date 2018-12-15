//
//  KarumiHQs.swift
//  SwiftKatas
//
//  Created by Pedro Vicente Gomez on 15/12/2018.
//  Copyright © 2018 Pedro's Lab. All rights reserved.
//

import Foundation
import Bow

class KarumiHQs<F> {

    let maxibonsToRefill: Int = 10
    let minNumberOfMaxibons: Int = 2

    func openFridge<ChatF, MonadF>(_ chat: ChatF, _ monad: MonadF,
                                   world: World, developers: [Developer]) ->  Kind<F, World> where
        MonadF: Monad, MonadF.F == F,
        ChatF: Chat, ChatF.F == F {
        return ListK<F>.foldable().foldM(
            developers.k(),
            world, { world, dev in
                self.openFridge(chat, monad, world: world, developer: dev)
            },
            monad)
    }

    func openFridge<ChatF, MonadF>(_ chat: ChatF, _ monad: MonadF,
                                   world: World, developer: Developer) ->  Kind<F, World> where
        MonadF: Monad, MonadF.F == F,
        ChatF: Chat, ChatF.F == F {
        let maxibonsLeft = computeMaxibonsLeft(world: world, dev: developer)
        return monad.binding(
            { refillMaxibonsIfNeeded(chat, monad, developer: developer, maxibonsLeft: maxibonsLeft) },
            { finalMaxibonsAmount in monad.pure(World._maxibonsLeft.set(world, finalMaxibonsAmount)) }
        )
    }

    private func refillMaxibonsIfNeeded<ChatF, MonadF>(_ chat: ChatF, _ monad: MonadF,
                                                       developer: Developer, maxibonsLeft: Int) -> Kind<F, Int> where
        MonadF: Monad, MonadF.F == F,
        ChatF: Chat, ChatF.F == F {
            if shouldRefillMaxibons(maxibonsLeft: maxibonsLeft) {
                return monad.binding(
                    { askTheTeamForMoreMaxibons(chat, developer: developer) },
                    {    _ in monad.pure(maxibonsLeft + self.maxibonsToRefill) }
                )
            } else {
                return monad.pure(maxibonsLeft)
            }
    }

    private func computeMaxibonsLeft(world: World, dev: Developer) -> Int {
        return max(0, world.karumiFridge.maxibonsLeft - dev.numberOfMaxibonsToGet)
    }

    private func shouldRefillMaxibons(maxibonsLeft: Int) -> Bool {
        return maxibonsLeft <= minNumberOfMaxibons
    }

    private func askTheTeamForMoreMaxibons<ChatF>(_ chat: ChatF, developer: Developer) ->  Kind<F, String> where
        ChatF: Chat, ChatF.F == F {
        return chat.sendMessage(message: "Hi there! I'm \(developer.name). We need more maxibons")
    }
}
