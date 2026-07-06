import Foundation
import UIKit

@MainActor
final class ListHeroesAdapter: NSObject, UITableViewDataSource {
    private(set) var heroes: [CharacterDataModel]

    private let tableView: UITableView

    init(tableView: UITableView, heroes: [CharacterDataModel] = []) {
        self.tableView = tableView
        self.heroes = heroes
        super.init()
        self.tableView.dataSource = self
    }

    func setHeroes(_ heroes: [CharacterDataModel]) {
        self.heroes = heroes
        tableView.reloadData()
    }

    func appendHeroes(_ newHeroes: [CharacterDataModel]) {
        let startIndex = heroes.count
        heroes.append(contentsOf: newHeroes)

        let indexPaths = newHeroes.indices.map {
            IndexPath(row: startIndex + $0, section: 0)
        }

        tableView.insertRows(at: indexPaths, with: .automatic)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ListHeroesTableViewCell",
            for: indexPath
        ) as! ListHeroesTableViewCell

        cell.configure(model: heroes[indexPath.row])
        return cell
    }
}
