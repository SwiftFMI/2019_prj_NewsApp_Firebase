import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login Controller"
    }
    
    @IBAction func login(_ sender: Any) {
        FirebaseManager.login(email: username.text!, password: password.text!) { (success : Bool) in
            if success {
                self.performSegue(withIdentifier: "showArticles", sender: sender)
            }
        }
    }
    
}
