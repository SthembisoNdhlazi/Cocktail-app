
import Foundation
import UIKit

protocol CocktailsNetworking {
    var baseURL: String { get set }
    func fetchJSON<T: Decodable>(drinkType: DrinkTypes, specificDrinkID: String?, completion: @escaping (Result<T, NetworkError>) -> Void)
}

enum DrinkTypes: String {
    case alcoholic = "filter.php?a=Alcoholic"
    case nonAlcoholic = "filter.php?a=Non_Alcoholic"
    case detailedDrink = "lookup.php?i="
}


enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
}

extension CocktailsNetworking {
    
    func fetchJSON<T: Decodable>(drinkType: DrinkTypes, specificDrinkID: String? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var url: URL?
        
        if let specificDrinkID = specificDrinkID {
            url = URL(string: baseURL + drinkType.rawValue + specificDrinkID)
        } else {
            url = URL(string: baseURL + drinkType.rawValue)
        }
        
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.requestFailed(error)))
            }
        }.resume()
    }
}
struct CocktailsServiceCalls: CocktailsNetworking {
    var baseURL: String = "https://www.thecocktaildb.com/api/json/v1/1/"
}


