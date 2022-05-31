//
//  BooksView.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 29/05/22.
//

import Foundation
import UIKit

class BooksView: UIView, ViewConfiguration {
    
    lazy var collectionViewBooks: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: "bookCell")
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionViewBooks.delegate = delegate
        collectionViewBooks.dataSource = dataSource
        initialize()
    }
    
    func addViews() {
        addSubview(collectionViewBooks)
    }
    
    func addConstraints() {
        collectionViewBooks.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionViewBooks.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionViewBooks.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionViewBooks.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
