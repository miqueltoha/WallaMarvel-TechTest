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

    private(set) var receivedName: String?
    private(set) var receivedPage: Int?
    private(set) var receivedNames: [String?] = []
    private(set) var receivedPages: [Int] = []

    func execute(
        name: String?,
        page: Int,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        receivedName = name
        receivedPage = page
        receivedNames.append(name)
        receivedPages.append(page)

        guard let result else { return }
        completionBlock(result)
    }
}
