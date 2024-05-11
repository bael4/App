//
//  TabBarController.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        generateTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: ProductListController(),
                title: "Product",
                image: UIImage(systemName: "house")
            ),
            generateVC(
                viewController: FavoritesProductListViewController(),
                title: "Favorite",
                image: UIImage(systemName: "heart")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return viewController
    }
    
    private func setTabBarAppearance() {

        tabBar.backgroundColor = .lightBlue
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .whiteBorder
        tabBar.barTintColor = .lightBlue

    }
    
}

