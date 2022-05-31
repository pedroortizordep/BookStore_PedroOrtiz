//
//  CustomImageView.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 30/05/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: NSString?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = NSString(string: urlString)
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                debugPrint(error)
                return
            }
            
            DispatchQueue.main.async {
                
                guard let data = data else { return }
                
                let imageToCache = UIImage(data: data)
                
                if self.imageUrlString == NSString(string: urlString) {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache ?? UIImage(), forKey: NSString(string: urlString))
            }
        }.resume()
    }
}
