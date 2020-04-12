//
//  Post.swift
//  InstagramFirebase
//
//  Created by Fred Lefevre on 2020-04-12.
//  Copyright © 2020 Fred Lefevre. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
