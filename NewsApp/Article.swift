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
        self.author = author ?? "Unknown author"
        self.content = content ?? "No content"
        self.description = description ?? "No description"
        self.url = url ?? "No URL"
        self.urlToImage = urlToImage ?? "No image URL"
        self.publishedAt = publishedAt ?? "Published at"
    }
    
    static func == (article: Article, other: Article) -> Bool {
        return article.title == other.title
    }
}
