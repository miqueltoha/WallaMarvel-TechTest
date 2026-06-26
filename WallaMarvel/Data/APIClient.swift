import Foundation

protocol APIClientProtocol {
    func getHeroes(
        name: String?,
        page: Int,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    )
}

final class APIClient: APIClientProtocol {
    
    private enum Constant {
        static let charactersEndpoint = "https://rickandmortyapi.com/api/character"
    }
    
    init() { }
    
    func getHeroes(
        name: String? = nil,
        page: Int,
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        guard var urlComponents = URLComponents(string: Constant.charactersEndpoint) else {
            completionBlock(.failure(URLError(.badURL)))
            return
        }
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        if let name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completionBlock(.failure(URLError(.badURL)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completionBlock(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completionBlock(.failure(URLError(.badServerResponse)))
                return
            }
            
            if httpResponse.statusCode == 404 {
                completionBlock(.failure(URLError(.fileDoesNotExist)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completionBlock(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data else {
                completionBlock(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(CharacterDataContainer.self, from: data)
                completionBlock(.success(dataModel))
            } catch {
                completionBlock(.failure(error))
            }
        }.resume()
    }
}
