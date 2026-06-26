//
//  GetHeroesUseCaseMock.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation
@testable import WallaMarvel

final class GetHeroesUseCaseMock: GetHeroesUseCaseProtocol {

    var result: Result<CharacterDataContainer, Error>?

    func execute(
        name: String?,
        page: Int,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        if let result {
            completionBlock(result)
        }
    }
}
