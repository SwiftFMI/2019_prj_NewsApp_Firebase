import UIKit

class RegistrationController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func register(_ sender: Any) {
        FirebaseManager.login(email: email.text!, password: password.text!) { (success : Bool) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showArticles", sender: sender)
            }
        }
    }
    
}
