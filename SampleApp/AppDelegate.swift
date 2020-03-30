//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Stanislas Chevallier on 30/03/2020.
//  Copyright © 2020 Syan.me. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.applyAppearance()
        
        let tabs: [UINavigationController] = (1..<4).map { index in
            let vc = ViewController()
            vc.title = "Tab \(index)"
            return NavigationController(rootViewController: vc)
        }
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = tabs
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = .red
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.barStyle = .black

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.layer.masksToBounds = true
        window?.layer.isOpaque = false
        window?.rootViewController = tabBarController

        return true
    }

}

