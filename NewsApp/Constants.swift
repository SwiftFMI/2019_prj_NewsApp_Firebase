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
    
    struct LocalSQLiteDatabase {
        static let likedTable = "liked"
        static let downloadedTable = "downloaded"
        
        static let createLikedTable = "CREATE TABLE IF NOT EXISTS " + likedTable + "(Id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, content TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT);"
        static let createDownloadedTable = "CREATE TABLE IF NOT EXISTS " + downloadedTable + "(Id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, content TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT);"
        
        static let selectLiked = "SELECT * FROM " + likedTable
        static let selectDownloaded = "SELECT * FROM " + downloadedTable
        
        static let insertIntoLiked = "INSERT INTO " + likedTable + "(title, author, content, description, url, urlToImage, publishedAt) VALUES (?, ?, ?, ?, ?, ?, ?);"
        static let insertIntoDownloaded = "INSERT INTO " + downloadedTable + "(title, author, content, description, url, urlToImage, publishedAt) VALUES  (?, ?, ?, ?, ?, ?, ?);"
        
        static let deleteFromLiked = "DELETE FROM " + likedTable + " WHERE Id = ?;"
    }
    
}
