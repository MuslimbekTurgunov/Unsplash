//
//  AppDelegate.swift
//  Lesson-61-Unsplash
//
//  Created by Mustafo Asqarov on 19/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let tabbar = MainTabbar.init()
        
        let home = HomeVC.init(nibName: "HomeVC", bundle: nil)
        let search = SearchVC(nibName: "SearchVC", bundle: nil)
        
        
        tabbar.viewControllers = [home, search]
        
        let homeBar = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        home.tabBarItem = homeBar
        
        let searchBar = UITabBarItem(title: "Search Image", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle"))
        search.tabBarItem = searchBar
        
        
        
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
        return true
    }

 

}

