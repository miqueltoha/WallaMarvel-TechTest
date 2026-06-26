//
//  CharacterDetailViewController.swift
//  WallaMarvel
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import UIKit
import Kingfisher

final class CharacterDetailViewController: UIViewController {

    private let character: CharacterDataModel

    private let imageView = UIImageView()
    private let stackView = UIStackView()

    init(character: CharacterDataModel) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = character.name
        view.backgroundColor = .systemBackground

        setupView()
        configure()
    }

    private func setupView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 220),
            imageView.heightAnchor.constraint(equalToConstant: 220),

            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func configure() {
        imageView.kf.setImage(with: URL(string: character.image))

        addInfo(title: "Status", value: character.status)
        addInfo(title: "Species", value: character.species)
        addInfo(title: "Gender", value: character.gender)
        addInfo(title: "Origin", value: character.origin.name)
        addInfo(title: "Location", value: character.location.name)
        addInfo(title: "Episodes", value: "\(character.episode.count)")
    }

    private func addInfo(title: String, value: String) {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "\(title): \(value)"
        stackView.addArrangedSubview(label)
    }
}
