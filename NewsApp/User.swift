import UIKit

class User: NSObject {
    
    var email: String;
    var uid: String
    
    init(email: String, uid: String) {
        self.email = email
        self.uid = uid
    }
}
