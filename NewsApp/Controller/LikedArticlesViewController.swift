import UIKit

class LikedArticlesViewController: MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articles = ArticlesManager.instance.likedArticles
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.articles = ArticlesManager.instance.likedArticles
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            ArticlesManager.instance.deleteArticle(articleIdx: indexPath.row)
            
            self.articles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        favorite.backgroundColor = .orange

        return [favorite]
    }

}
