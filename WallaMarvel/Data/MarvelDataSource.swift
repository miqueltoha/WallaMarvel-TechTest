import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(
        name: String?,
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
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        apiClient.getHeroes(name: name, completionBlock: completionBlock)
    }
}
