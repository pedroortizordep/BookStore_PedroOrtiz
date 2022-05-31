//
//  BookDetailViewModel.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 30/05/22.
//

import Foundation

class BookDetailViewModel {
    
    private let book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func getBook() -> Book {
        return self.book
    }
}
