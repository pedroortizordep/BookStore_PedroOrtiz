//
//  BookViewModel.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 29/05/22.
//

import Foundation

class BookViewModel {
    
    private var booksService: BooksService
    
    private(set) var books: [BookModel] {
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
    
    func cleanBooks() {
        self.booksService.cleanService()
        self.books = []
    }
    
    func getBook(index: Int) -> BookModel {
        return books[index]
    }
    
    func getFavoriteBooks() {
        booksService.isPaginating = true
        
        let favoritesData: [Book] = DataManager.shared.getBooksData()
        var favoriteBooks: [BookModel] = []
        
        for data in favoritesData {
            let book = BookModel(volumeInfo: VolumeInfo(title: data.title ?? "", authors: [data.authors ?? ""], description: data.bookDescription, imageLinks: ImageLinks(thumbnail: data.thumbnail ?? "")), saleInfo: SaleInfo(buyLink: data.buyLink))
            favoriteBooks.append(book)
        }
        
        self.books = favoriteBooks
    }
}
