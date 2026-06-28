//
//  GetHeroesUseCaseMock.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation
@testable import WallaMarvel

@MainActor
final class GetHeroesUseCaseMock: GetHeroesUseCaseProtocol {
    
    var result: Result<CharacterDataContainer, Error> = .success(.mock())
    
    private(set) var receivedName: String?
    private(set) var receivedPage: Int?
    private(set) var receivedNames: [String?] = []
    private(set) var receivedPages: [Int] = []
    
    func execute(name: String?, page: Int) async throws -> CharacterDataContainer {
        receivedName = name
        receivedPage = page
        receivedPages.append(page)
        
        switch result {
        case .success(let container):
            return container
        case .failure(let error):
            throw error
        }
    }
}
