import UIKit

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let articlesManager = ArticlesManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Main Controller"
    }
    
}

