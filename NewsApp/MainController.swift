import UIKit

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let articlesManager = ArticlesManager()
    
    var selectedArticle: Article?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesManager.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Make cells reusables
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        let currentArticle = articlesManager.articles[indexPath.row]
        
        cell.imageView?.image = UIImage.init(named: "Article")
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = currentArticle.description
        cell.textLabel?.text = currentArticle.title
        
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
        // TODO: register segue
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
        
    }
}

