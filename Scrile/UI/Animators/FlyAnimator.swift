//
//  FlyAnimator.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class FlyAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isInAnimation(context: transitionContext) {
            animateIn(context: transitionContext)
        } else {
            animateOut(context: transitionContext)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }
    
    func isInAnimation(context: UIViewControllerContextTransitioning) -> Bool {
        guard let fromViewController = context.viewController(forKey: .from) else { return true }        
        return fromViewController.isKind(of: MainViewController.self)
    }
    
    func animateIn(context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from), let toViewController = context.viewController(forKey: .to)  else { return }
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: self.transitionDuration(using: context),
                       animations: {
                        fromViewController.view.alpha = 0
                        toViewController.view.backgroundColor = UIColor.yellow
                        toViewController.view.alpha = 1
        }) { (completed) in
            context.completeTransition(completed)
        }
    }
    
    func animateOut(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from), let toViewController = context.viewController(forKey: .to)  else { return }
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: self.transitionDuration(using: context),
                       animations: {
                        fromViewController.view.alpha = 0
                        toViewController.view.alpha = 1
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
