//
//  Book.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 29/05/22.
//

import Foundation

struct BookResponse: Codable {
    let items: [BookModel]
}

struct BookModel: Codable {
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let description: String?
    let imageLinks: ImageLinks
}

struct SaleInfo: Codable {
    let buyLink: String?
}

struct ImageLinks: Codable {
    let thumbnail: String
}
