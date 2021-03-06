//
//  SceneDelegate.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 19/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = CreateTabBar()
        window?.makeKeyAndVisible()
         
    }
    
    func ConfigureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemRed
    }
    
    func CreateSearchNC() -> UINavigationController {
        let searchVC = Search_VC()
        searchVC.tabBarItem = UITabBarItem(title: "News Feed", image: SFSymbols.newsFeed, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func CreateFavouritesNC() -> UINavigationController {
        let favouriteListVC = FavouritesList_VC()
        favouriteListVC.title = "Favourites"
        favouriteListVC.tabBarItem = UITabBarItem(title: "Favourites", image: SFSymbols.favourites, tag: 1)
        return UINavigationController(rootViewController: favouriteListVC)
    }
    
    func CreateTabBar() -> UITabBarController {
        ConfigureNavigationBar()
        
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemRed
        tabBar.viewControllers = [CreateSearchNC(), CreateFavouritesNC()]
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

