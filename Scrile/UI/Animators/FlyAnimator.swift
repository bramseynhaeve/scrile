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
        guard let fromViewController = context.viewController(forKey: .from) as? UICollectionViewController,
              let toViewController = context.viewController(forKey: .to),
              let collectionView = fromViewController.collectionView else { return }
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)
        toViewController.view.alpha = 0
        
        for (index, cell) in collectionView.visibleCells.enumerated() {
            
            let side = collectionView.side(for: cell)
            cell.backgroundColor = side.color()
            let cellOffset = side.flyOffset(size: cell.frame.size)
            
            UIView.animate(withDuration: 2, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
                cell.transform = CGAffineTransform(translationX: cellOffset.width, y: cellOffset.height)
            }, completion: { (completed) in

            })
        }
        
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
        guard let fromViewController = context.viewController(forKey: .from),
            let toViewController = context.viewController(forKey: .to) as? UICollectionViewController,
            let collectionView = toViewController.collectionView else { return }
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: self.transitionDuration(using: context),
                       animations: {
                        fromViewController.view.alpha = 0
                        toViewController.view.alpha = 1
                        
                        for (index, cell) in collectionView.visibleCells.enumerated() {
                            cell.transform = CGAffineTransform.identity
                        }
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
