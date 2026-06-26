//
//  ApiClientMock.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation
@testable import WallaMarvel

final class APIClientMock: APIClientProtocol {

    var result: Result<CharacterDataContainer, Error>?

    func getHeroes(
        name: String?,
        page: Int,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        guard let result else {
            fatalError("Result not configured")
        }

        completionBlock(result)
    }
}
