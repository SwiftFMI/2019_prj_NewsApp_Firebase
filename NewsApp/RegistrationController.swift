import UIKit

class RegistrationController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register_click(_ sender: Any) {
        FirebaseManager.register(email: email.text!, password: password.text!) { (result: String) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "registerSegue", sender: sender)
            }
        }
    }
}
