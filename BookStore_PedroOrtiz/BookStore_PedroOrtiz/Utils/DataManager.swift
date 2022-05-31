//
//  DataManager.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 30/05/22.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func createBookCoreDataModel(bookModel: BookModel) {
        let book = Book(context: persistentContainer.viewContext)
        
        book.title = bookModel.volumeInfo.title
        book.bookDescription = bookModel.volumeInfo.description
        book.thumbnail = bookModel.volumeInfo.imageLinks.thumbnail
        book.buyLink = bookModel.saleInfo.buyLink ?? ""
        
        var authors: String = ""
        
        for author in bookModel.volumeInfo.authors {
            authors.append(author)
        }
        
        book.authors = authors
    }
    
    func delete(bookModel: BookModel) {
        let fetchedBooks: [Book] = getBooksData()
        
        for book in fetchedBooks {
            if book.title == bookModel.volumeInfo.title { persistentContainer.viewContext.delete(book) }
        }
    }
    
    func getBooksData() -> [Book] {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        var fetchedBooks: [Book] = []
        
        do {
            fetchedBooks = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error")
        }
        
        return fetchedBooks
    }
    
    func exists(bookModel: BookModel) -> Bool {
        let fetchedBooks: [Book] = getBooksData()
        
        for book in fetchedBooks {
            if book.title == bookModel.volumeInfo.title { return true }
        }
        
        return false
    }

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
