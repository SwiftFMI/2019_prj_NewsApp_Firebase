import UIKit

class User: NSObject {
    var email: String
    var uid: String
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
