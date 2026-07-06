import Foundation

import Foundation

protocol MarvelRepositoryProtocol: Sendable {
    func getHeroes(
        name: String?,
        page: Int
    ) async throws -> CharacterDataContainer
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol

    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }

    func getHeroes(
        name: String?,
        page: Int
    ) async throws -> CharacterDataContainer {
        try await dataSource.getHeroes(name: name, page: page)
    }
}
