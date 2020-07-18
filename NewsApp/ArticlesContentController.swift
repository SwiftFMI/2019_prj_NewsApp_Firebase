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
            // TODO: code duplication
            let imageUrl = URL(string: selectedArticle!.urlToImage)!
            let session = URLSession(configuration: .default)
            let _ = session.dataTask(with: imageUrl) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let res = response as? HTTPURLResponse {
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
        DbManager.instance.insert(id: 3, title: selectedArticle!.title, author: selectedArticle!.author)
        print("DATABASE: saved objects count after insert: )", DbManager.instance.read().count)
    }
    
}
