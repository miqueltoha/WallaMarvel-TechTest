import Foundation

protocol APIClientProtocol: Sendable {
    func getHeroes(name: String?, page: Int) async throws -> CharacterDataContainer
}

final class APIClient: APIClientProtocol {
    
    private enum Constant {
        static let charactersEndpoint = "https://rickandmortyapi.com/api/character"
    }
    
    init() { }
    
    func getHeroes(name: String? = nil, page: Int) async throws -> CharacterDataContainer {
        guard var urlComponents = URLComponents(string: Constant.charactersEndpoint) else {
            throw URLError(.badURL)
        }
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let trimmedName, !trimmedName.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: trimmedName))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(CharacterDataContainer.self, from: data)
    }
}
