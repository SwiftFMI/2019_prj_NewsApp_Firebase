import UIKit

class MainViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    var articles: [Article] = []
    
    var filteredArticles: [Article] = []
    
    var selectedArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupSearchBar()
    }
    
    // SEARCH BAR
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // TABLE VIEW
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArticles.count
        }
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Make cells reusable
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        
        let currentArticle: Article
        
        if isFiltering {
            currentArticle = filteredArticles[indexPath.row]
        } else {
            currentArticle = articles[indexPath.row]
        }
        
        cell.imageView?.image = UIImage.init(named: "Article")
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = currentArticle.description
        cell.textLabel?.text = currentArticle.title
        
        // Download image
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
        
//        let imageData = DataService.instance.downloadImage(imageUrl: imageUrl)
//        let image = UIImage(data: imageData!)
//        cell.imageView?.clipsToBounds = true
//        cell.imageView?.image = image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            selectedArticle = filteredArticles[indexPath.row]
        } else {
            selectedArticle = articles[indexPath.row]
        }
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let favorite = UITableViewRowAction(style: .normal, title: "Save") { action, index in
//            ArticlesManager.instance.saveArticle(articleType: Constants.LocalSQLiteDatabase.likedTable, article: self.selectedArticle!)
//        }
//        favorite.backgroundColor = .orange
//        
//        return [favorite]
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showContentSegue,
            let destinationViewController = segue.destination as? ArticlesContentController {
            destinationViewController.selectedArticle = selectedArticle
        }
    }
    
    // LOG OUT
    @IBAction func logout_click(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: Constants.UserDefaultsKeys.isUserLoggedIn)
        UserDefaults.standard.synchronize()
        
        UsersManager.logout()
        self.performSegue(withIdentifier: Constants.Segue.logoutSegue, sender: self)
    }

}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredArticles = ArticlesManager.instance.downloadedArticles.filter { (article: Article) -> Bool in
            return article.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
