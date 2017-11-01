//
//  FlipAnimator.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class FlipAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isInAnimation(context: transitionContext) {
            animateIn(context: transitionContext)
        } else {
            animateOut(context: transitionContext)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func isInAnimation(context: UIViewControllerContextTransitioning) -> Bool {
        guard let fromViewController = context.viewController(forKey: .from) else { return true }
        return fromViewController.isKind(of: NumberCollectionViewController.self)
    }
    
    func animateIn(context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from) as? UICollectionViewController,
            let toViewController = context.viewController(forKey: .to) as? UICollectionViewController,
            let fromCollectionView = fromViewController.collectionView,
            let toCollectionView = toViewController.collectionView else { return }
        
        containerView.insertSubview(toViewController.view, at: 0)
        containerView.insertSubview(fromViewController.view, at: 1)
        
        toCollectionView.contentOffset = fromCollectionView.contentOffset
        
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            fromCollectionView.alpha = 0
            toCollectionView.alpha = 1
        }) { (completed) in
            context.completeTransition(completed)
        }
    }
    
    func animateOut(context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from) as? UICollectionViewController,
            let toViewController = context.viewController(forKey: .to) as? UICollectionViewController,
            let fromCollectionView = fromViewController.collectionView,
            let toCollectionView = toViewController.collectionView else { return }
        
        containerView.insertSubview(toViewController.view, at: 0)
        containerView.insertSubview(fromViewController.view, at: 1)
        
        toCollectionView.contentOffset = fromCollectionView.contentOffset
        
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            fromCollectionView.alpha = 0
            toCollectionView.alpha = 1
        }) { (completed) in
            context.completeTransition(completed)
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
