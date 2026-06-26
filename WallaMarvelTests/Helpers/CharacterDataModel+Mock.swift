//
//  CharacterDataModel+Mock.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation
@testable import WallaMarvel

extension CharacterDataModel {

    static func mock(
        id: Int = 1,
        name: String = "Rick Sanchez"
    ) -> CharacterDataModel {

        CharacterDataModel(
            id: id,
            name: name,
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: CharacterLocationDataModel(
                name: "Earth",
                url: ""
            ),
            location: CharacterLocationDataModel(
                name: "Earth",
                url: ""
            ),
            image: "https://example.com/image.jpg",
            episode: [],
            url: "",
            created: ""
        )
    }
}
