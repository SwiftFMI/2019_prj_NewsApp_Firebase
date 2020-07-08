import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ProfileManager: NSObject {
    
    static let db = Database.database().reference()
    static let uid = Auth.auth().currentUser?.uid
    
    static var users = [User] ()
    
    static func getCurrentUser(uid: String) -> User? {
        if let idx = users.firstIndex(where: {$0.uid == uid}) {
            return users[idx]
        }
        return nil
    }
    
    static func fillUsers(completion: @escaping () -> Void) {
        users = []
        db.child("Users").observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject] {
                let uid = result["uid"]! as! String
                let email = result["email"]! as! String
                
                let u = User(uid: uid, email: email)
                
                ProfileManager.users.append(u)
            }
            completion()
        })
    }

}
