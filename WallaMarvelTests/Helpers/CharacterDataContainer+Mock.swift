//
//  CharacterDataContainer+Mock.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation
@testable import WallaMarvel

extension CharacterDataContainer {

    static func mock(
        characters: [CharacterDataModel] = [.mock()],
        pages: Int = 1
    ) -> CharacterDataContainer {
        CharacterDataContainer(
            info: PageInfoDataModel(
                count: characters.count,
                pages: pages,
                next: nil,
                prev: nil
            ),
            characters: characters
        )
    }
}
