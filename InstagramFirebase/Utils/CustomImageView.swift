//
//  CustomImageView.swift
//  InstagramFirebase
//
//  Created by Fred Lefevre on 2020-05-19.
//  Copyright © 2020 Fred Lefevre. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    var lastUrlUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        
        lastUrlUsedToLoadImage = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            
            if url.absoluteString != self.lastUrlUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
            }.resume()
    }
}
