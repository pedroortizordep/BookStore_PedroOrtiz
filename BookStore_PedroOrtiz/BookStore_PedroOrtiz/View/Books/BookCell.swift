//
//  BookCell.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 29/05/22.
//

import Foundation
import UIKit

class BookCell: UICollectionViewCell, ViewConfiguration {
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageViewThumbnail: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    func configure(book: Book) {
        initialize()
        
        let urlString = book.volumeInfo.imageLinks.thumbnail
        imageViewThumbnail.loadImageUsingUrlString(urlString: urlString)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewThumbnail.image = nil
    }
    
    func addViews() {
        addSubview(viewContainer)
        viewContainer.addSubview(imageViewThumbnail)
    }
    
    func addConstraints() {
        viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        viewContainer.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        imageViewThumbnail.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor).isActive = true
        imageViewThumbnail.topAnchor.constraint(equalTo: viewContainer.topAnchor).isActive = true
        imageViewThumbnail.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor).isActive = true
        imageViewThumbnail.heightAnchor.constraint(equalTo: viewContainer.heightAnchor).isActive = true
    }
}
