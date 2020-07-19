import Foundation

class Article: Equatable {
    
    var title: String
    var author: String
    var content: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    
    init(_ title: String, _ author: String?, _ content: String?, _ description: String?, _ url: String?, _ urlToImage: String?, _ publishedAt: String?) {
        self.title = title
        self.author = author ?? Constants.ArticlesDefaultValues.author
        self.content = content ?? Constants.ArticlesDefaultValues.content
        self.description = description ?? Constants.ArticlesDefaultValues.description
        self.url = url ?? Constants.ArticlesDefaultValues.url
        self.urlToImage = urlToImage ?? Constants.ArticlesDefaultValues.urlToImage
        self.publishedAt = publishedAt ?? Constants.ArticlesDefaultValues.publishedAt
    }
    
    static func == (article: Article, other: Article) -> Bool {
        return article.title == other.title
    }
}
