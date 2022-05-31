//
//  BookViewModel.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 29/05/22.
//

import Foundation

class BookViewModel {
    
    private var booksService: BooksService
    
    private(set) var books: [Book] {
        didSet {
            self.bindBooksToController()
        }
    }
    
    var isPaginating: Bool {
        get { return booksService.isPaginating}
    }
    
    var bindBooksToController: (() -> ()) = {}
    
    init() {
        booksService = BooksService()
        books = []
    }
    
    func getBooks(pagination: Bool = false) {
        
        booksService.getBooks(pagination: pagination) { result in
            switch result {
            case .success(let booksResponse):
                self.booksService.isPaginating = false
                self.books.append(contentsOf: booksResponse.items)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getBook(index: Int) -> Book {
        return books[index]
    }
}
