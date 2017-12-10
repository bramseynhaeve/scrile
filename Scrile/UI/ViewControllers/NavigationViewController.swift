//
//  NavigationViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController, UINavigationControllerDelegate {
    
    let popFlyAnimator = PopFlyAnimator()
    let pushFlyAnimator = PushFlyAnimator()
    let popFlipAnimator = PopFlipAnimator()
    let pushFlipAnimator = PushFlipAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            additionalSafeAreaInsets = UIEdgeInsetsMake(-statusBarHeight, 0, -statusBarHeight, 0)
        }
        
        isNavigationBarHidden = true
        automaticallyAdjustsScrollViewInsets = false
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            return pushAnimatorForViewController(viewController: toVC)
            
        case .pop:
            return popAnimatorForViewController(viewController: fromVC)
            
        default:
            return nil
        }
    }
    
    func popAnimatorForViewController(viewController: UIViewController) -> UIViewControllerAnimatedTransitioning {
        if viewController.isKind(of: TileCollectionViewController.self) {
            return popFlipAnimator
        }
        
        return popFlyAnimator
    }
    
    func pushAnimatorForViewController(viewController: UIViewController) -> UIViewControllerAnimatedTransitioning {
        if viewController.isKind(of: TileCollectionViewController.self) {
            return pushFlipAnimator
        }
        
        return pushFlyAnimator
    }
}
