import UIKit

class LikedArticlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedArticle: Article?
    
    var likedArticles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.likedArticles = DbManager.instance.getAllArticles(table: Constants.LocalSQLiteDatabase.likedTable)
        print("DATABASE: saved objects count on liked loading VIEW DID LOAD: )", likedArticles.count)
        
        definesPresentationContext = true
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DATABASE: saved objects count on liked loading: )", likedArticles.count)
//        return likedArticles.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        let currentArticle = likedArticles[indexPath.row]
        
//        if isFiltering {
//            currentArticle = filteredArticles[indexPath.row]
//        } else {
//            currentArticle = articlesManager.articles[indexPath.row]
//        }
        
        cell.imageView?.image = UIImage.init(named: "Article")
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = "author"
        cell.textLabel?.text = "title"
        
        // Download image
        // TODO: Code duplication (ArticlesContentController)
        
//        if currentArticle.urlToImage != "" {
//
//            let imageUrl = URL(string: currentArticle.urlToImage)!
//            let session = URLSession(configuration: .default)
//            let _ = session.dataTask(with: imageUrl) { (data, response, error) in
//                if let e = error {
//                    print("Error downloading picture: \(e)")
//                } else {
//                    if let res = response as? HTTPURLResponse {
//                        if let imageData = data {
//                            let image = UIImage(data: imageData)
//                            cell.imageView?.clipsToBounds = true
//                            cell.imageView?.image = image
//                        } else {
//                            print("Couldn't get image: Image is nil")
//                        }
//                    } else {
//                        print("Couldn't get response code for some reason")
//                    }
//                }
//                }.resume()
//        }
        
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedArticle = DbManager.dbManager.getArticleById(tableView.get)
//    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let favorite = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
//            DbManager.instance.insert(id: 1, title: self.selectedArticle!.title, author: self.selectedArticle!.author)
//        }
//        favorite.backgroundColor = .orange
//
//        return [favorite]
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Constants.Segue.showContentSegue,
//            let destinationViewController = segue.destination as? ArticlesContentController {
//            destinationViewController.selectedArticle = selectedArticle
//        }
//    }

}
