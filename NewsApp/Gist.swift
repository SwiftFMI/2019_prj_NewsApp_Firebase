import Foundation

struct Gist : Codable{
    var articles: [ArticleJson]
}

struct ArticleJson : Codable{
    var title: String
    var author: String
    var description: String
    var content: String
    var publishedAt: String
    var urlToImage: String
    
    init(from decoder: Decoder) throws {
        // this container will hold key-value pairs
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        
        // These keys might have null values    
        self.author = try container.decodeIfPresent(String.self, forKey: .author) ?? "Unknown author"
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "No description"
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? "No content"
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
    }
}
