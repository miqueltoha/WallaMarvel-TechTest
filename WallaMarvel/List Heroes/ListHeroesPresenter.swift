import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes(name: String?)
    func loadNextPage()
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
}

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

        currentPage += 1
        loadCharacters(page: currentPage, name: currentSearchText)
    }

    private func loadCharacters(page: Int, name: String?) {
        isLoading = true

        getHeroesUseCase.execute(name: name, page: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }

                self.isLoading = false

                switch result {
                case .success(let characterDataContainer):
                    self.totalPages = characterDataContainer.info.pages

                    if page == 1 {
                        self.characters = characterDataContainer.characters
                    } else {
                        self.characters.append(contentsOf: characterDataContainer.characters)
                    }

                    self.ui?.update(heroes: self.characters)

                case .failure(let error):
                    print("Failed loading characters:", error)

                    if page == 1 {
                        self.characters = []
                        self.ui?.update(heroes: [])
                    }
                }
            }
        }
    }
}
