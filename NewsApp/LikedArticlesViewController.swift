import UIKit

class LikedArticlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DbManager.dbManager.getArticles().values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Make cells reusable
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedArticle = DbManager.dbManager.getArticleById(tableView.get)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "Save") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = .orange
        
        return [favorite]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContent",
            let destinationViewController = segue.destination as? ArticlesContentController {
            destinationViewController.selectedArticle = selectedArticle
        }
    }

}
