import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login_click(_ sender: Any) {
        let email = "inikolay@vmware.com"
        let pass = "Inikolay123!"
        FirebaseManager.login(email: email, password: pass) { (success: Bool) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: sender)
            } else {
                print()
            }
        }
    }
}
