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
        characters: [CharacterDataModel] = [.mock()]
    ) -> CharacterDataContainer {

        CharacterDataContainer(
            info: PageInfoDataModel(
                count: characters.count,
                pages: 1,
                next: nil,
                prev: nil
            ),
            characters: characters
        )
    }
}
