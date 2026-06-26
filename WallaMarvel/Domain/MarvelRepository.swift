import Foundation

protocol MarvelRepositoryProtocol {
    func getHeroes(
        name: String?,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    )
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(
        name: String?,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        dataSource.getHeroes(name: name, completionBlock: completionBlock)
    }
}
