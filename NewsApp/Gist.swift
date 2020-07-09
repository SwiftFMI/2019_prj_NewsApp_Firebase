import Foundation

struct Gist : Codable{
    var articles: [ArticleJson]
}

struct ArticleJson : Codable{
    var title: String
    var url: String
}
