import Foundation

struct CharacterDataModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterLocationDataModel
    let location: CharacterLocationDataModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
