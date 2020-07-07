import Foundation

class Article {
    var title: String = "Article's title"
    var description: String = "Article's description"
    
    init() {
    }
    
    init(_ title: String, _ description: String) {
        self.title = title
        self.description = description
    }
    
}
