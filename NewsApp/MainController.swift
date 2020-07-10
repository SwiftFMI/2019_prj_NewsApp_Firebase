import UIKit

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let articlesManager = ArticlesManager()
    
    var filteredArticles: [Article] = []
    
    var selectedArticle: Article?

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    @IBAction func logout_click(_ sender: Any) {
        UsersManager.logout()
        self.performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.shared.getData { (result) in
            switch result {
                case .success(let articles) :
                    for articleJson in articles {
                        let article = Article(articleJson.title, articleJson.author, articleJson.description, articleJson.content, articleJson.urlToImage)
                        self.articlesManager.articles.append(article)
                    }
                case .failure(let error):
                    print(error)
            }
            
            
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        
        setupSearchBar()
    }
    
    // SEARCH BAR
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredArticles = articlesManager.articles.filter { (article: Article) -> Bool in
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
    
    // TABLE VIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArticles.count
        }
        return articlesManager.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Make cells reusables
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        let currentArticle: Article
        
        if isFiltering {
            currentArticle = filteredArticles[indexPath.row]
        } else {
            currentArticle = articlesManager.articles[indexPath.row]
        }
        
        cell.imageView?.image = UIImage.init(named: "Article")
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = currentArticle.description
        cell.textLabel?.text = currentArticle.title
        
        // Download image
        if currentArticle.urlToImage != "" {
            
            let imageUrl = URL(string: currentArticle.urlToImage)!
            let session = URLSession(configuration: .default)
            let _ = session.dataTask(with: imageUrl) { (data, response, error) in
                // The download has finished.
                if let e = error {
                    print("Error downloading cat picture: \(e)")
                } else {
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded picture with response code \(res.statusCode)")
                        if let imageData = data {
                            // Finally convert that Data into an image and do what you wish with it.
                            let image = UIImage(data: imageData)
                            cell.imageView?.image = image
                            //                            cell.imageView?.contentMode = .scaleToFill
                            //                            cell.imageView?.clipsToBounds = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articlesManager.articles[indexPath.row]
        self.performSegue(withIdentifier: "showContent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContent",
            let destinationViewController = segue.destination as? ArticlesContentController {
            destinationViewController.selectedArticle = selectedArticle
        }
    }
}

