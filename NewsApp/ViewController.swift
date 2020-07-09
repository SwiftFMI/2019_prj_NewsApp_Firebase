import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let articlesManager = ArticlesManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesManager.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Make cells reusables
        print("tableView")
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        let currentArticle = articlesManager.articles[indexPath.row]
        
        cell.imageView?.image = UIImage.init(named: "Article")
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = currentArticle.description
        cell.textLabel?.text = currentArticle.title
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.title = "Main Controller"
        
        DataService.shared.getData { (result) in
            switch result {
                case .success(let articles) :
                    for articleJson in articles {
                        self.articlesManager.articles.append(Article(articleJson.title, articleJson.url))
                    }
                    self.tableView.reloadData() // TODO: should be called from main thread
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}

