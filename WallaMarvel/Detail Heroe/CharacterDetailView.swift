//
//  CharacterDetailView.swift
//  WallaMarvel
//
//  Created by Miquel Toha Perera on 28/06/2026.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    let character: CharacterDataModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                KFImage(URL(string: character.image))
                    .placeholder {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.secondary)
                            .padding(48)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .accessibilityLabel("Image of \(character.name)")

                VStack(alignment: .leading, spacing: 12) {
                    detailRow(title: "Status", value: character.status)
                    detailRow(title: "Species", value: character.species)
                    detailRow(title: "Gender", value: character.gender)
                    detailRow(title: "Origin", value: character.origin.name)
                    detailRow(title: "Location", value: character.location.name)
                    detailRow(title: "Episodes", value: "\(character.episode.count)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailRow(title: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(title):")
                .font(.headline)

            Text(value)
                .font(.body)

            Spacer()
        }
        .accessibilityElement(children: .combine)
    }
}
