//
//  PageInfoDataModel.swift
//  WallaMarvel
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import Foundation

struct PageInfoDataModel: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
