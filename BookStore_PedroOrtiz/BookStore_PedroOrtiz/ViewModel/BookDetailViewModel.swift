//
//  BookDetailViewModel.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 30/05/22.
//

import Foundation

class BookDetailViewModel {
    
    private let book: BookModel
    
    init(book: BookModel) {
        self.book = book
    }
    
    func getBook() -> BookModel {
        return self.book
    }
    
    func unfavoriteBook(bookModel: BookModel) {
        DataManager.shared.delete(bookModel: bookModel)
        DataManager.shared.save()
    }
    
    func favoriteBook(bookModel: BookModel) {
        DataManager.shared.createBookCoreDataModel(bookModel: bookModel)
        DataManager.shared.save()
    }
    
    func existFavoriteBook(bookModel: BookModel) -> Bool {
        return DataManager.shared.exists(bookModel: bookModel)
    }
}
