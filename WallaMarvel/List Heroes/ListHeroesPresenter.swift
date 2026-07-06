import Foundation

@MainActor
protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes(name: String?)
    func loadNextPage()
}

@MainActor
protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
}

@MainActor
final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    private var currentSearchText: String?
    private var characters: [CharacterDataModel] = []
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "Characters"
    }
    
    // MARK: UseCases
    
    func getHeroes(name: String? = nil) {
        currentPage = 1
        currentSearchText = name
        characters = []
        loadCharacters(page: currentPage, name: name)
    }
    
    func loadNextPage() {
        guard !isLoading, currentPage < totalPages else { return }
        
        loadCharacters(page: currentPage + 1, name: currentSearchText)
    }
    
    private func loadCharacters(page: Int, name: String?) {
        isLoading = true
        
        let getHeroesUseCase = getHeroesUseCase
        
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            do {
                let characterDataContainer = try await getHeroesUseCase.execute(
                    name: name,
                    page: page
                )
                
                self.isLoading = false
                self.currentPage = page
                self.totalPages = characterDataContainer.info.pages
                
                if page == 1 {
                    self.characters = characterDataContainer.characters
                } else {
                    self.characters.append(contentsOf: characterDataContainer.characters)
                }
                
                self.ui?.update(heroes: self.characters)
                
            } catch {
                self.isLoading = false
                
                guard page == 1 else { return }
                
#if DEBUG
                print("Failed loading characters:", error)
#endif
                
                self.characters = []
                self.ui?.update(heroes: [])
            }
        }
    }
}
