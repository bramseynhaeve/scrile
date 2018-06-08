//
//  NavigationViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController, UINavigationControllerDelegate {
    
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
        if
            let fromViewController = viewControllers.first as? TileCollectionViewController,
            let toViewController = viewController as? TileCollectionViewController
        {
            return fromViewController.tiles.count == toViewController.tiles.count ? PopFlipAnimator() : DoubleFlyAnimator()
        }
        
        return PopFlyAnimator()
    }
    
    func pushAnimatorForViewController(viewController: UIViewController) -> UIViewControllerAnimatedTransitioning {

        var modifiedViewControllers = viewControllers
        modifiedViewControllers.removeLast()

        if
            let fromViewController = modifiedViewControllers.last as? TileCollectionViewController,
            let toViewController = viewController as? TileCollectionViewController
        {
            return fromViewController.tiles.count == toViewController.tiles.count ? PushFlipAnimator() : DoubleFlyAnimator()
        }
        
        return PushFlyAnimator()
    }
}
