//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Fred Lefevre on 2020-04-01.
//  Copyright © 2020 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navigationController = UINavigationController(rootViewController: loginController)
                self.present(navigationController, animated: true, completion: nil)
            }
            return
        }
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navigationController = UINavigationController(rootViewController: userProfileController)
        
        navigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        
        tabBar.tintColor = .black
        
        viewControllers = [navigationController]
    }
}
