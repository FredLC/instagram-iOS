//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Fred Lefevre on 2020-04-01.
//  Copyright © 2020 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navigationController = UINavigationController(rootViewController: loginController)
                self.present(navigationController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        let homeController = templateNavController(selectedImage: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let searchController = templateNavController(selectedImage: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"))
        
        let plusController = templateNavController(selectedImage: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"))
        
        let likeController = templateNavController(selectedImage: #imageLiteral(resourceName: "like_selected"), unselectedImage: #imageLiteral(resourceName: "like_unselected"))
        
        // user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let userNavController = UINavigationController(rootViewController: userProfileController)
        
        userNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        userNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeController, searchController, plusController, likeController, userNavController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
