//
//  BookDetailViewController.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 30/05/22.
//

import Foundation
import UIKit

class BookDetailViewController: UIViewController, ViewConfiguration {
    
    private var customView: BookDetailView = BookDetailView()
    private var viewModel: BookDetailViewModel
    
    init(book: BookModel) {
        viewModel = BookDetailViewModel(book: book)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setup()
    }
    
    private func setup() {
        setupNavigation()
        
        initialize()
        customView.setupView(book: viewModel.getBook())
    }
    
    private func setupNavigation() {
        navigationItem.title = "Details"
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(named: "favorite"), style: .plain,
                target: self,
                action: #selector(favoriteBook)
            )
            
        ]
        
        let bookModel = viewModel.getBook()
        
        navigationItem.rightBarButtonItems?.forEach({ item in
            
            if viewModel.existFavoriteBook(bookModel: bookModel) {
                item.tintColor = .orange
            } else {
                item.tintColor = .lightGray
            }
        })
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func favoriteBook() {
        let bookModel = viewModel.getBook()
        
        navigationItem.rightBarButtonItems?.forEach({ item in
            if item.tintColor == .orange {
                item.tintColor = .lightGray
                viewModel.unfavoriteBook(bookModel: bookModel)
            } else {
                item.tintColor = .orange
                viewModel.favoriteBook(bookModel: bookModel)
            }
        })
    }
    
    func addViews() {
        view.addSubview(customView)
    }
    
    func addConstraints() {        
        customView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        customView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
