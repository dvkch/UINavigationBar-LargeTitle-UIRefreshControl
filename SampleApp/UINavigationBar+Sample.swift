//
//  UINavigationBar+Sample.swift
//  SampleApp
//
//  Created by Stanislas Chevallier on 30/03/2020.
//  Copyright © 2020 Syan.me. All rights reserved.
//

import UIKit

extension UINavigationBar {
    static func applyAppearance() {
        if #available(iOS 13.0, *) {
            let navigationBar = UINavigationBarAppearance()
            navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.configureWithOpaqueBackground()
            navigationBar.backgroundColor = .red

            let appearance = UINavigationBar.appearance(whenContainedInInstancesOf: [NavigationController.self])
            appearance.prefersLargeTitles = true
            appearance.compactAppearance = navigationBar
            appearance.standardAppearance = navigationBar
            appearance.scrollEdgeAppearance = navigationBar
            appearance.tintColor = .white
        }
        else {
            let navigationBar = UINavigationBar.appearance(whenContainedInInstancesOf: [NavigationController.self])
            navigationBar.prefersLargeTitles = true
            navigationBar.isTranslucent = false
            navigationBar.tintColor = .white
            navigationBar.barTintColor = .red
            navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

