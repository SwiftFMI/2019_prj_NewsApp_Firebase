import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: NSObject {
    
    static let db = Database.database().reference()
        
    static var currentUser: User? = nil
    
    static func login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
//                currentUser = Auth.auth().currentUser
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
                    print("Loging successfull after account creation")
                } else {
                    print("Loging unsuccessfull after account creation")
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

    
}
