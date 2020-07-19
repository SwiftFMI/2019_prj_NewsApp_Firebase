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
                let storyboard = UIStoryboard(name: Constants.StoryBoardNames.main, bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifiers.mainTabBarId)
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
                
                // keep user logged in
                UserDefaults.standard.set(true, forKey: Constants.UserDefaultsKeys.isUserLoggedIn)
                UserDefaults.standard.synchronize()
            }
        }
    }
}
