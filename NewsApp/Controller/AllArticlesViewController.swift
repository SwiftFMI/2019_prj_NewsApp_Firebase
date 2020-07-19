import UIKit
import Network

class AllArticlesViewController: MainViewController {
    
    // Internet connection
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                NSLog("Internet connection is on.")
                DataService.instance.downloadData { (result) in
                    switch result {
                    case .success(let articles) :
                        for articleJson in articles {
                            let article = Article(articleJson.title, articleJson.author, articleJson.content, articleJson.description, articleJson.url, articleJson.urlToImage, articleJson.publishedAt)
                            self.articles.append(article)
                            ArticlesManager.instance.saveArticle(articleType: Constants.ArticlesType.downloaded, article: article)
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                    DispatchQueue.main.sync {
                        self.tableView.reloadData()
                    }
                }
            } else {
                NSLog("There's no internet connection.")
                let downloadedArticles = DbManager.instance.getAllArticles(table: Constants.LocalSQLiteDatabase.downloadedTable)
                self.articles.append(contentsOf: downloadedArticles)
                ArticlesManager.instance.downloadedArticles = downloadedArticles
                
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "Save") { action, index in
            ArticlesManager.instance.saveArticle(articleType: Constants.LocalSQLiteDatabase.likedTable, article: self.selectedArticle!)
        }
        favorite.backgroundColor = .orange
        
        return [favorite]
    }
}

