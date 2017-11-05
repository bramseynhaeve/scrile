//
//  NavigationViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            additionalSafeAreaInsets = UIEdgeInsetsMake(-statusBarHeight, 0, -statusBarHeight, 0)
        }
        
        isNavigationBarHidden = true
        automaticallyAdjustsScrollViewInsets = false
    }
}
