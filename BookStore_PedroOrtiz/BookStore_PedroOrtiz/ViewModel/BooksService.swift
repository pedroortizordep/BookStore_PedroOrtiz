//
//  BooksService.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 29/05/22.
//

import Foundation
import Alamofire

class BooksService {
    
    private var booksURL: String = "https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=5&startIndex="
    private var startIndex: Int = 0
    
    var isPaginating = false
    
    func cleanService() {
        startIndex = 0
        isPaginating = false
    }
    
    func getBooks(pagination: Bool = false, completion: @escaping (Result<BookResponse, Error>) -> ()) {
        
        if pagination {
            self.isPaginating = true
            startIndex += 5
        }
        
        let requestURL = "\(booksURL)\(startIndex)"
        
        AF.request(requestURL)
            .response { response in
                
                if let error = response.error {
                    completion(.failure(error))
                }
                
                guard let data = response.data else { return }
                
                do {
                    let bookResponse: BookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
                    completion(.success(bookResponse))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}
