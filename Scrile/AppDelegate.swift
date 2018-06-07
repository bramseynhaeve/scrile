//
//  AppDelegate.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 04/07/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // TODO: Dynamic number
        let numbers = Array(0...22).map { (index) -> NumberTile in
            return NumberTile(number: index)
        }

        let tileCollectionViewController = TileCollectionViewController(tiles: numbers)
        let navigationController = NavigationViewController(rootViewController: tileCollectionViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

