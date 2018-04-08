//
//  MainTabBarController.swift
//  DavalaProject
//
//  Created by znfod on 2018. 4. 3..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        self.setTabLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabLayout() {
        let itemListStoryboard: UIStoryboard = UIStoryboard(name: "ItemList", bundle: nil)
        let itemListViewController:ItemListViewController = itemListStoryboard.instantiateInitialViewController() as!  ItemListViewController
        let itemListNavigation:UINavigationController = UINavigationController.init(rootViewController: itemListViewController)
        itemListNavigation.tabBarItem.image = UIImage.init(named: "tab_bottom_home.png")
        
        let categoryListStoryboard: UIStoryboard = UIStoryboard(name: "CategoryList", bundle: nil)
        let categoryListViewController:CategoryListViewController = categoryListStoryboard.instantiateInitialViewController() as!  CategoryListViewController
        let categoryListNavigation:UINavigationController = UINavigationController.init(rootViewController: categoryListViewController)
        categoryListNavigation.tabBarItem.image = UIImage.init(named: "tab_bottom_list.png")
        
        let reviewFeedStoryboard: UIStoryboard = UIStoryboard(name: "ReviewFeed", bundle: nil)
        let productDetailViewController:ReviewFeedViewController = reviewFeedStoryboard.instantiateInitialViewController() as!  ReviewFeedViewController
        let reviewFeedNavigation:UINavigationController = UINavigationController.init(rootViewController: productDetailViewController)
        reviewFeedNavigation.tabBarItem.image = UIImage.init(named: "tab_bottom_review.png")
        
        let searchStoryboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let searchViewController:UIViewController = searchStoryboard.instantiateInitialViewController() as!  UIViewController
        let searchNavigation:UINavigationController = UINavigationController.init(rootViewController: searchViewController)
        searchNavigation.tabBarItem.image = UIImage.init(named: "tab_bottom_search.png")
        
        let privateStoryboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let privateViewController:UIViewController = privateStoryboard.instantiateInitialViewController() as!  UIViewController
        let privateNavigation:UINavigationController = UINavigationController.init(rootViewController: privateViewController)
        privateNavigation.tabBarItem.image = UIImage.init(named: "tab_bottom_private.png")
        
        let myViewControllers = [itemListNavigation, categoryListNavigation, reviewFeedNavigation, searchNavigation, privateNavigation]
        self.viewControllers = myViewControllers
    }

}
