import Foundation
import SQLite3

class DbManager: NSObject {
    
    var isDbOpen: Bool = false
    var lastError: Error? = nil
    var db: OpaquePointer? = nil
    var versions: [String] = ["1.0"]
    var cachePath: String  = ""
    
    static let dbManager = DbManager()
    
    private override init() {
        let fileUrl = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Articles.db")
        self.cachePath = fileUrl.path
    }
    
    func openDb() -> Int32 {
        let result = sqlite3_open(self.cachePath as String, &self.db)
        if result == SQLITE_OK {
            self.isDbOpen = true
        }
        return result
    }
    
    func closeDb() -> Int32 {
        let result = sqlite3_close(db)
        if result == SQLITE_OK {
            self.isDbOpen = false
            db = nil
        }
        return result
    }
    
    func addArticle(article: [String:Article]) -> (Int, Int64) {
        if !self.isDbOpen {
            openDb()
        }
        
//        let error: Error = Error()
        var changes = 0
        var lastInsertId: Int64 = -1
        
        let columnNames = Array<String>(article.keys)
        var columnValues = [String]()
        
        for colName in columnNames {
            columnValues.append("'\(article[colName]!)'")
        }
        
        let colNameStr = columnNames.joined(separator: ",")
        let colValueStr = columnValues.joined(separator: ",")
        let sql = "INSERT INTO Articles (" + colNameStr + ") VALUES( " + colValueStr + ")"
        
        let result = sqlite3_exec(self.db, sql, nil, nil, nil)
        if result != SQLITE_OK {
            let errStr = String(cString: sqlite3_errstr(result))
//            error = .SQLError(errStr)
        } else {
            changes = Int(sqlite3_changes(self.db))
            lastInsertId = Int64(sqlite3_last_insert_rowid(self.db))
        }
        
        return (changes, lastInsertId)
    }
    
    func getArticles() -> ([String:[[String:Article]]]) {
//        var error: Error?
        var articles: [String:[[String:Article]]] = [:]
        return (articles)
    }
    
    func getArticleById(id: Int64) -> ([String:Article]?) {
//        var error: Error? = nil
        var article: [String:Article]? = nil
        
        if !self.isDbOpen {
            openDb()
        }
        return(article)
    }
    
    func deleteArticle(id: Int64) -> (Int){
//        var error: Error?
        var changes: Int = 0
        
        if !isDbOpen {
            openDb()
        }
        
        return (changes)
    }
}
