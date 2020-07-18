import UIKit

class LikedArticlesViewController: UITableViewController {
    
    var selectedArticle: Article?
    
    var likedArticles = ArticlesManager.instance.likedArticles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath)
        
        let currentArticle = likedArticles[indexPath.row]
        
//        if isFiltering {
//            currentArticle = filteredArticles[indexPath.row]
//        } else {
//            currentArticle = articlesManager.articles[indexPath.row]
//        }
        
        cell.imageView?.image = UIImage.init(named: "Article")
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = currentArticle.author
        cell.textLabel?.text = currentArticle.title
        
        // TODO: Code duplication (ArticlesContentController)с
        if currentArticle.urlToImage != "" {

            let imageUrl = URL(string: currentArticle.urlToImage)!
            let session = URLSession(configuration: .default)
            let _ = session.dataTask(with: imageUrl) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let res = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            cell.imageView?.clipsToBounds = true
                            cell.imageView?.image = image
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
                }.resume()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = likedArticles[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            ArticlesManager.instance.deleteArticle(articleIdx: indexPath.row)
        }
        favorite.backgroundColor = .orange

        return [favorite]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showContentSegue,
            let destinationViewController = segue.destination as? ArticlesContentController {
            destinationViewController.selectedArticle = selectedArticle
        }
    }

}
