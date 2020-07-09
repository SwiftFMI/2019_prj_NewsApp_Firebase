import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class UsersManager: NSObject {
    
    static let db = Database.database().reference()
    static let uid = Auth.auth().currentUser?.uid
    
    static var users = [User]()
    
    static func getCurrentUser(uid: String) -> User? {
        if let idx = users.lastIndex(where: {$0.uid == uid}) {
            return users[idx]
        }
        return nil
    }
    
    static func fillUsers(completion: @escaping () -> Void) {
        users = []
        db.child("Users").observe(.childAdded) { (snapshot) in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject] {
                let uid = result["uid"] as! String
                let email = result["email"] as! String
                
                let user = User(email: email, uid: uid)
                UsersManager.users.append(user)
            }
            completion()
        }
        
    }
    
}
