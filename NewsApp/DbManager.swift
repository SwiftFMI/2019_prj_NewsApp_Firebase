import Foundation
import SQLite3

class DbManager {
    
    static let instance = DbManager()
    
    let dbPath: String = "db.sqlite"
    var db:OpaquePointer?
    
    init() {
        db = openDatabase()
        createTable()
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
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS liked(Id INTEGER PRIMARY KEY, title TEXT, author TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("liked table created.")
            } else {
                print("liked table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(id: Int, title: String, author: String) {
//        let persons = read()
//        for p in persons {
//            if p.id == id {
//                print("This id already exists")
//                return
//            }
//        }
        
        let insertStatementString = "INSERT INTO liked (Id, title, author) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (author as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("DATABASE: Successfully inserted row.")
            } else {
                print("DATABASE: Could not insert row.")
            }
        } else {
            print("DATABASE: INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Article] {
        let queryStatementString = "SELECT * FROM liked;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Article] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let author = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                psns.append(Article(title, author, "", "", "", "", ""))
                print("Query Result:")
                print("\(id) | \(title) | \(author)")
            }
        } else {
            print("DATABASE: SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM liked WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("DATABASE: Successfully deleted row.")
            } else {
                print("DATABASE: Could not delete row.")
            }
        } else {
            print("DATABASE: DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
