import UIKit

class ArticlesContentController: UIViewController {
    
    @IBOutlet weak var articlesTitle: UILabel!
    
    @IBOutlet weak var articlesContent: UITextView!

    @IBOutlet weak var articlesImage: UIImageView!

    var selectedArticle: Article?
    
    override func viewDidLoad() {
        if selectedArticle?.title != nil && selectedArticle?.content != nil {
                articlesTitle.text = selectedArticle?.title
            
            articlesContent.text = selectedArticle?.content
            
        }
        
        if selectedArticle?.urlToImage != nil {
            
            let imageUrl = URL(string: selectedArticle!.urlToImage)!
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
                            self.articlesImage.image = image
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
        
        super.viewDidLoad()
    }
    
    @IBAction func readMoreClick(_ sender: Any) {
        if let url = URL(string: selectedArticle!.url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func saveClick(_ sender: Any) {
    }
    
    //    @IBAction func readMoreAction(_ sender: Any) {
////        let originalUrl = selectedArticle?.url
////        UIApplication.shared.openURL(NSURL(fileURLWithPath: originalUrl!) as URL)
//        
//        
//        if let url = URL(string: selectedArticle!.url) {
//            UIApplication.shared.open(url)
//        }
//    }
//    
//    @IBAction func saveAction(_ sender: Any) {
//    }
    
    
}
