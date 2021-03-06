import UIKit

class RegistrationController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register_click(_ sender: Any) {
        UsersManager.register(email: email.text!, password: password.text!) { (result: String) in
            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: Constants.Segue.registerSegue, sender: sender)
                let storyboard = UIStoryboard(name: Constants.StoryBoardNames.main, bundle: nil)
                let loginNavigation = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifiers.loginNavigationControllerId)
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(loginNavigation)
            }
        }
    }
}
