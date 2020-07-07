import Foundation

class ArticlesManager {
    var articles: [Article] = []
    
    init() {
        for _ in 0..<30 {
            articles.append(Article())
        }
    }
}
