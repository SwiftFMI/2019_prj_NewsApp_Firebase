import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login_click(_ sender: Any) {
        UsersManager.login(email: email.text!, password: password.text!) { (success: Bool) in
            if success {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(withIdentifier: Constants.instance.mainTabBarId)
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
            } else {
                print()
            }
        }
    }
}
