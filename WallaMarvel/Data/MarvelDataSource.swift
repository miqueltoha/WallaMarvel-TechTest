import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(
        name: String?,
        page: Int,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    )
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(
        name: String?,
        page: Int,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        apiClient.getHeroes(name: name, page: page, completionBlock: completionBlock)
    }
}
