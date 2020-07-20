import Foundation

class ArticlesManager {
    
    static let instance = ArticlesManager()
    
    var downloadedArticles: [Article] = []
    var likedArticles: [Article] = []
    
    init() {
        downloadedArticles = LocalSqlDbManager.instance.getAllArticles(table: Constants.LocalSQLiteDatabase.downloadedTable)
        likedArticles = LocalSqlDbManager.instance.getAllArticles(table: Constants.LocalSQLiteDatabase.likedTable)
    }
    
    func saveArticle(articleType: String, article: Article) {
        switch articleType {
            case Constants.ArticlesType.liked:
                if !likedArticles.contains(article) {
                    likedArticles.append(article)
                }
                LocalSqlDbManager.instance.saveArticle(table: Constants.LocalSQLiteDatabase.likedTable, article: article)
            case Constants.ArticlesType.downloaded:
                if !downloadedArticles.contains(article){
                    downloadedArticles.append(article)
                }
                LocalSqlDbManager.instance.saveArticle(table: Constants.LocalSQLiteDatabase.downloadedTable, article: article)
            default:
                return
        }
    }
    
    func deleteArticle(articleIdx: Int) {
        let article = likedArticles.remove(at: articleIdx)
        LocalSqlDbManager.instance.deleteArticle(title: article.title)
    }
    
    func articleExistsInLiked(article: Article) {
        
    }
     
}
