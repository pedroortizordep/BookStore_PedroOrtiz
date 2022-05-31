//
//  BooksViewController.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 29/05/22.
//

import Foundation
import UIKit

class BooksViewController: UIViewController, ViewConfiguration {
    
    private var customView: BooksView = BooksView()
    private var viewModel: BookViewModel = BookViewModel()
    
    override func viewDidLoad() {
        setup()
        viewModel.getBooks()
    }
    
    private func setup() {
        setupNavigation()
        
        initialize()
        customView.setupView(delegate: self, dataSource: self)
        bindBooks()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Books"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func bindBooks() {
        viewModel.bindBooksToController = {
            self.customView.collectionViewBooks.reloadData()
        }
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
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

extension BooksViewController: UICollectionViewDelegate {}

extension BooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2.2, height: view.frame.size.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension BooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCell {
            let book = viewModel.getBook(index: indexPath.row)
            cell.configure(book: book)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = viewModel.getBook(index: indexPath.row)
        let viewController = BookDetailViewController(book: book)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BooksViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > self.customView.collectionViewBooks.contentSize.height - 100 - scrollView.frame.size.height {
            
            if self.viewModel.isPaginating { return }
            
            self.viewModel.getBooks(pagination: true)
        }
    }
}
