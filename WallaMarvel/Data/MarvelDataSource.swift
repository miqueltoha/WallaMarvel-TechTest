import Foundation

import Foundation

protocol MarvelDataSourceProtocol: Sendable {
    func getHeroes(
        name: String?,
        page: Int
    ) async throws -> CharacterDataContainer
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func getHeroes(
        name: String?,
        page: Int
    ) async throws -> CharacterDataContainer {
        try await apiClient.getHeroes(name: name, page: page)
    }
}
