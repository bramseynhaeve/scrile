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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let option = UserDefaults.standard.lastUserFlow() == .numbers ? OptionType.numbers : OptionType.tshirt
        guard let tileCollectionViewController = option.viewController else {
            fatalError("We need a ViewController to start the app")
        }
        
        let navigationController = NavigationViewController(rootViewController: tileCollectionViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

