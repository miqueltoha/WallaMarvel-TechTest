//
//  CharacterDetailViewController.swift
//  WallaMarvel
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import UIKit
import SwiftUI

final class CharacterDetailViewController: UIHostingController<CharacterDetailView> {

    init(character: CharacterDataModel) {
        super.init(rootView: CharacterDetailView(character: character))
    }

    @MainActor
    @available(*, unavailable)
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
