import Foundation

protocol GetHeroesUseCaseProtocol {
    func execute(
        name: String?,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) 
}

struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }
    
    func execute(
        name: String?,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        repository.getHeroes(name: name, completionBlock: completionBlock)
    }
}
