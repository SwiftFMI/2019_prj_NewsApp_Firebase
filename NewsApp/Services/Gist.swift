import Foundation

struct Gist : Codable{
    var articles: [ArticleJson]
}

struct ArticleJson : Codable{
    var title: String
    var author: String
    var content: String
    var description: String
    var url: String
    var urlToImage: String
    
    init(from decoder: Decoder) throws {
        // this container will hold key-value pairs
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        
        // These keys might have null values    
        self.author = try container.decodeIfPresent(String.self, forKey: .author) ?? Constants.ArticlesDefaultValues.author
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? Constants.ArticlesDefaultValues.content
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? Constants.ArticlesDefaultValues.description
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? Constants.ArticlesDefaultValues.url
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? Constants.ArticlesDefaultValues.urlToImage
    }
}
