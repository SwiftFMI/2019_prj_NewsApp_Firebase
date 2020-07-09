import UIKit

class DataService {
    
    static let shared = DataService()
    
    fileprivate let apiUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    fileprivate let apiKey = "710e1dac2cea4f8faf0b308acb22603a"
    
    func getData(completion: @escaping (Result<[ArticleJson], Error>) -> Void) {
        let fullUrl = URL(string: apiUrl + apiKey)
        
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
