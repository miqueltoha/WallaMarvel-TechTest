//
//  ListHeroesUIMock.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation
@testable import WallaMarvel

final class ListHeroesUIMock: ListHeroesUI {

    var heroes: [CharacterDataModel] = []
    var updateCalled = false

    var onUpdate: (() -> Void)?

    func update(heroes: [CharacterDataModel]) {
        updateCalled = true
        self.heroes = heroes
        onUpdate?()
    }
}
