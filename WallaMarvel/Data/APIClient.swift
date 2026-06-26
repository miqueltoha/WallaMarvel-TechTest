import Foundation

protocol APIClientProtocol {
    func getHeroes(completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void)
}

final class APIClient: APIClientProtocol {

    private enum Constant {
        static let charactersEndpoint = "https://rickandmortyapi.com/api/character"
    }

    init() { }

    func getHeroes(completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void) {
        guard let url = URL(string: Constant.charactersEndpoint) else {
            completionBlock(.failure(URLError(.badURL)))
            return
        }

        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completionBlock(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
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
                if let rawResponse = String(data: data, encoding: .utf8) {
                    print("Raw response:", rawResponse)
                }
                completionBlock(.failure(error))
            }
        }.resume()
    }
}
