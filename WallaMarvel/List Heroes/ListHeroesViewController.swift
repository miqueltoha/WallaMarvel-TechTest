import UIKit

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        view = ListHeroesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        presenter?.getHeroes(name: nil)
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search character"
        searchController.searchBar.sizeToFit()
        
        mainView.heroesTableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }

}

extension ListHeroesViewController: ListHeroesUI {
    func update(heroes: [CharacterDataModel]) {
        listHeroesProvider?.setHeroes(heroes)
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let character = listHeroesProvider?.heroes[indexPath.row] else {
            return
        }
        
        let detailViewController = CharacterDetailViewController(character: character)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalRows = listHeroesProvider?.heroes.count ?? 0
        
        guard totalRows > 0 else { return }
        
        if indexPath.row == totalRows - 3 {
            presenter?.loadNextPage()
        }
    }
}

extension ListHeroesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if let text, !text.isEmpty {
            presenter?.getHeroes(name: text)
        } else {
            presenter?.getHeroes(name: nil)
        }
    }
}
