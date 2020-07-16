import UIKit

class ArticlesContentController: UIViewController {
    
    @IBOutlet weak var articlesTitle: UILabel!
    
    @IBOutlet weak var articlesAuthor: UITextView!
    
    @IBOutlet weak var articlesContent: UITextView!

    @IBOutlet weak var publishedAt: UITextView!
    
    @IBOutlet weak var articlesImage: UIImageView!

    var selectedArticle: Article?
    
    override func viewDidLoad() {        
        articlesTitle.text = selectedArticle?.title
        articlesTitle.adjustsFontSizeToFitWidth = true
        articlesAuthor.text = selectedArticle?.author
        articlesContent.text = selectedArticle?.content
        publishedAt.text = String(selectedArticle?.publishedAt.prefix(10) ?? "Published at" )
        
        if selectedArticle?.urlToImage != nil {
            
            let imageUrl = URL(string: selectedArticle!.urlToImage)!
            let session = URLSession(configuration: .default)
            let _ = session.dataTask(with: imageUrl) { (data, response, error) in
                if let e = error {
                    print("Error downloading cat picture: \(e)")
                } else {
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded picture with response code \(res.statusCode)")
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.articlesImage.image = image
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
            }.resume()
        }
        
        super.viewDidLoad()
    }
    
    @IBAction func readMoreClick(_ sender: Any) {
        if let url = URL(string: selectedArticle!.url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func saveClick(_ sender: Any) {
        let articleId = selectedArticle!.title.prefix(3) + selectedArticle!.url.suffix(5)
        DbManager.dbManager.addArticle(article: [String(articleId): selectedArticle!])
    }
    
}
