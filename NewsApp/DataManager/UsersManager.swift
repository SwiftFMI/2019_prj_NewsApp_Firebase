import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class UsersManager: NSObject {
    
    static let db = Database.database().reference()
    
    static var users = [User]()
    
    static var currentUser: User? = nil
    
    static func login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                completion(false)
            } else {
                completion(true)
            }
        })
    }
    
    static func register(email: String, password: String, completion: @escaping(_ result: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            addUser(email: email)
            login(email: email, password: password, completion: { (success: Bool) in
                if success {
                    print("Login successfull")
                } else {
                    print("Could not log in")
                }
            })
            completion("")
        })
    }
    
    static func addUser(email: String) {
        let uid = Auth.auth().currentUser?.uid
        let user = ["uid" : uid!, "email" : email]
        db.child("users").child(uid!).setValue(user)
    }
    
    static func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Log out error")
        }
    }
    
}
