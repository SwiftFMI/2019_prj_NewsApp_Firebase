import Foundation

class ArticlesManager {
    
    static let instance = ArticlesManager()
    
    var downloadedArticles: [Article] = []
    var likedArticles: [Article] = []
    
    init() {
        downloadedArticles = DbManager.instance.getAllArticles(table: Constants.LocalSQLiteDatabase.downloadedTable)
        likedArticles = DbManager.instance.getAllArticles(table: Constants.LocalSQLiteDatabase.likedTable)
    }
    
    // TODO: create enum for article types
    func saveArticle(articleType: String, article: Article) {
        switch articleType {
            case Constants.ArticlesType.liked:
                likedArticles.append(article)
                DbManager.instance.saveArticle(table: Constants.LocalSQLiteDatabase.likedTable, article: article)
            case Constants.ArticlesType.downloaded:
                downloadedArticles.append(article)
                DbManager.instance.saveArticle(table: Constants.LocalSQLiteDatabase.downloadedTable, article: article)
            default:
                return
        }
    }
    
    func deleteArticle(articleIdx: Int) {
        let article = likedArticles.remove(at: articleIdx)
        DbManager.instance.deleteArticle(title: article.title)
    }
    
}
