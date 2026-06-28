import Foundation

import Foundation

protocol GetHeroesUseCaseProtocol: Sendable {
    func execute(
        name: String?,
        page: Int
    ) async throws -> CharacterDataContainer
}

struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol

    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }

    func execute(
        name: String?,
        page: Int
    ) async throws -> CharacterDataContainer {
        try await repository.getHeroes(name: name, page: page)
    }
}
