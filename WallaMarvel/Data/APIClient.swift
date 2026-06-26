import Foundation

protocol APIClientProtocol {
    func getHeroes(
        name: String?,
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
        completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
    ) {
        guard var urlComponents = URLComponents(string: Constant.charactersEndpoint) else {
            completionBlock(.failure(URLError(.badURL)))
            return
        }
        
        if let name, !name.isEmpty {
            urlComponents.queryItems = [URLQueryItem(name: "name", value: name)]
        }
        
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
