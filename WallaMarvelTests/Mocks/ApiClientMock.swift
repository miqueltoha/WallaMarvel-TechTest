//
//  ApiClientMock.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation
@testable import WallaMarvel

final class APIClientMock: APIClientProtocol, @unchecked Sendable {

    var result: Result<CharacterDataContainer, Error> = .success(.mock())

    func getHeroes(
        name: String?,
        page: Int
    ) async throws -> CharacterDataContainer {
        switch result {
        case .success(let container):
            return container
        case .failure(let error):
            throw error
        }
    }
}
