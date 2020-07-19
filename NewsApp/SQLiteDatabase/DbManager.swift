import Foundation
import SQLite3

class DbManager {
    
    static let instance = DbManager()
    
    let dbPath: String = "db.sqlite"
    var db:OpaquePointer?
    
    init() {
        db = openDatabase()
        
//        dropTable("liked")
//        dropTable("downloaded")
        
        createTable(Constants.LocalSQLiteDatabase.createLikedTable)
        createTable(Constants.LocalSQLiteDatabase.createDownloadedTable)
    }
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable(_ createTableSqlStr: String) {
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableSqlStr, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("table created.")
            } else {
                print("table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func dropTable(_ table: String) {
        var dropTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, "DROP TABLE " + table, -1, &dropTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE {
                print("table deleted.")
            } else {
                print("table could not be deleted.")
            }
        } else {
            print("DROP TABLE statement could not be prepared.")
        }
        sqlite3_finalize(dropTableStatement)
    }
    
    func saveArticle(table: String, article: Article) {
        // Check if article is already saved
        let savedArticles = getAllArticles(table: table)
        for savedArticle in savedArticles {
            if savedArticle.title == article.title {
                print("This article is already saved")
                return
            }
        }
        
        let insertStatementString: String

        switch table {
            case Constants.LocalSQLiteDatabase.likedTable:
                insertStatementString = Constants.LocalSQLiteDatabase.insertIntoLiked
            case Constants.LocalSQLiteDatabase.downloadedTable:
                insertStatementString = Constants.LocalSQLiteDatabase.insertIntoDownloaded
            default:
                insertStatementString = ""
        }
        
        var insertStatement: OpaquePointer? = nil
        let state = sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)
        if state == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 2, (article.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (article.author as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (article.content as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (article.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (article.url as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (article.urlToImage as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (article.publishedAt as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("DATABASE: Successfully inserted row.")
            } else {
                print("DATABASE: Could not insert row.")
            }
        } else {
            print("DATABASE: INSERT statement could not be prepared: ")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func getAllArticles(table: String) -> [Article] {
        let selectStatementStr: String
        
        switch table {
            case Constants.LocalSQLiteDatabase.likedTable:
                selectStatementStr = Constants.LocalSQLiteDatabase.selectLiked
            case Constants.LocalSQLiteDatabase.downloadedTable:
                selectStatementStr = Constants.LocalSQLiteDatabase.selectDownloaded
            default:
                selectStatementStr = ""
        }
        
        var queryStatement: OpaquePointer? = nil
        var result : [Article] = []
        if sqlite3_prepare_v2(db, selectStatementStr, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let author = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let content = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let url = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let urlToImage = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
//                let publishedAt = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))

                result.append(Article(title, author, content, description, url, urlToImage, ""))
            }
        } else {
            print("DATABASE: SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return result
    }
    
//    func getLikedArticleByTitle(title: String) -> Int {
//        let selectStatementStr = Constants.LocalSQLiteDatabase.selectByTitleFromLiked
//
//        var queryStatement: OpaquePointer? = nil
//        var slectedArticleId: Int
//        if sqlite3_prepare_v2(db, selectStatementStr, -1, &queryStatement, nil) == SQLITE_OK {
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                slectedArticleId = Int(sqlite3_column_int(queryStatement, 0))
//            }
//        } else {
//            print("DATABASE: SELECT statement could not be prepared")
//        }
//        sqlite3_finalize(queryStatement)
//        return slectedArticleId
//    }
    
    func deleteArticle(title: String) {
        let deleteStatementStirng = Constants.LocalSQLiteDatabase.deleteFromLiked
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, (title as NSString).utf8String, -1, nil)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("DATABASE: Successfully deleted row.")
            } else {
                print("DATABASE: Could not delete row.")
            }
        } else {
            print("DATABASE: DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
        print(getAllArticles(table: Constants.LocalSQLiteDatabase.likedTable).count)
    }
}
