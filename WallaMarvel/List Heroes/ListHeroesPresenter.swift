import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes(name: String?)
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "Characters"
    }
    
    // MARK: UseCases
    
    func getHeroes(name: String? = nil) {
        getHeroesUseCase.execute(name: name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characterDataContainer):
                    self?.ui?.update(heroes: characterDataContainer.characters)
                    
                case .failure(let error):
                    print("Failed loading characters:", error)
                    self?.ui?.update(heroes: [])
                }
            }
        }
    }
}

