//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Fred Lefevre on 2020-04-01.
//  Copyright © 2020 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        fetchUser()
    }
    
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let username = dictionary["username"] as? String
            self.navigationItem.title = username
        }) { (error) in
            print("Failed to fetch user: ", error)
        }
    }
}
