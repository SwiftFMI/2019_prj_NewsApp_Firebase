import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login_click(_ sender: Any) {
        FirebaseManager.login(email: email.text!, password: password.text!) { (success: Bool) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: sender)
            } else {
                print()
            }
        }
    }
}
