import Foundation

struct Constants {
    
    struct StoryBoardNames {
        static let main = "Main"
    }
    
    struct ViewControllerIdentifiers {
        static let mainTabBarId = "MainTabBarNavigationController"
        static let loginNavigationControllerId = "LoginNavigationController"
    }
    
    struct Messages {
        
    }
    
    struct URLs {
        static let apiUrl = "https://newsapi.org/v2/top-headlines?country=de&apiKey="
        static let apiKey = "710e1dac2cea4f8faf0b308acb22603a"
    }
    
    struct Segue {
        static let registerSegue = "registerSegue"
        static let logoutSegue = "logoutSegue"
        static let showContentSegue = "showContent"
    }

    struct UserDefaultsKeys {
        static let isUserLoggedIn = "isUserLoggedIn"
    }
    
}
