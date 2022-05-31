//
//  BookDetailView.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 30/05/22.
//

import Foundation
import UIKit

class BookDetailView: UIView, ViewConfiguration {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageViewThumbnail: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.applyStyle(color: .black, fontName: .appleSDBold, size: 24)
        return label
    }()
    
    private lazy var labelAuthor: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.applyStyle(color: .lightGray, fontName: .appleSDRegular, size: 18)
        return label
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.applyStyle(color: .lightGray, fontName: .appleSDRegular, size: 18)
        return label
    }()
    
    private lazy var labelBuyLink: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
    
    func setupView(book: BookModel) {
        initialize()
        
        let urlString = book.volumeInfo.imageLinks.thumbnail
        imageViewThumbnail.loadImageUsingUrlString(urlString: urlString)
        
        labelTitle.text = book.volumeInfo.title
        
        var authorsStr = ""
        for author in book.volumeInfo.authors {
            authorsStr.append("\(author) ")
        }
        
        labelAuthor.text = authorsStr
        
        labelDescription.text = book.volumeInfo.description
        
        guard let buyLink = book.saleInfo.buyLink else { return }
        let substringRange = NSString(string: buyLink).range(of: buyLink)
        let attributedString = NSMutableAttributedString(string: buyLink)
        attributedString.addAttribute(.link, value: buyLink, range: substringRange)
        attributedString.addAttribute(.font, value: UIFont(name: FontName.appleSDRegular.rawValue, size: 18) ?? UIFont(), range: substringRange)
        
        labelBuyLink.attributedText = attributedString
    }
    
    func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(imageViewThumbnail)
        scrollView.addSubview(labelTitle)
        scrollView.addSubview(labelAuthor)
        scrollView.addSubview(labelDescription)
        scrollView.addSubview(labelBuyLink)
    }
    
    func addConstraints() {
        
        let safeG = safeAreaLayoutGuide
        let contentG = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 8.0),
            scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 8.0),
            scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: -8.0),
            scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor, constant: -8.0),
            
            imageViewThumbnail.topAnchor.constraint(equalTo: contentG.topAnchor),
            imageViewThumbnail.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageViewThumbnail.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            imageViewThumbnail.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
                    
            labelTitle.topAnchor.constraint(equalTo: imageViewThumbnail.bottomAnchor, constant: 16.0),
            labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            
            labelAuthor.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            labelAuthor.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 4),
            labelAuthor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            
            labelDescription.topAnchor.constraint(equalTo: labelAuthor.bottomAnchor, constant: 24),
            labelDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelDescription.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
                    
            labelBuyLink.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 16),
            labelBuyLink.leadingAnchor.constraint(equalTo: labelDescription.leadingAnchor),
            labelBuyLink.trailingAnchor.constraint(equalTo: labelDescription.trailingAnchor),
            labelBuyLink.bottomAnchor.constraint(equalTo: contentG.bottomAnchor, constant: -16.0),
        ])
    }
}
