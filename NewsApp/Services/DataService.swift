import UIKit

class DataService {
    
    static let instance = DataService()
    
    func downloadData(completion: @escaping (Result<[ArticleJson], Error>) -> Void) {
        let fullUrl = URL(string: Constants.URLs.apiUrl + Constants.URLs.apiKey)
        
        URLSession.shared.dataTask(with: fullUrl!) { (data, response, error) in
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let gist = try JSONDecoder().decode(Gist.self, from: validData)
                completion(.success(gist.articles))
            } catch let serializationError {
                completion(.failure(serializationError))    
            }
        }.resume()
    }
}
