//
//  CharacterDataContainer.swift
//  WallaMarvel
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation

struct CharacterDataContainer: Decodable {
  
    let info: PageInfoDataModel
    let characters: [CharacterDataModel]
  
    enum CodingKeys: String, CodingKey {
      case info
      case characters = "results"
    }
}
