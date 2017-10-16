//
//  FlyAnimator.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class FlyAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    let delay = 0.02
    let touchDelay = 0.15
    let tileTransitionDuration = 0.16
    
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
        
        let sortedCells = collectionView.visibleCells.sorted { (cell1, cell2) -> Bool in            
            if cell1.isSelected { return true }
            if cell2.isSelected { return false }
            
            let side = collectionView.side(for: cell1)
            return side.isAtBorder()
        }
        
        for (index, cell) in sortedCells.enumerated() {
            
            let side = collectionView.side(for: cell)
            let cellOffset = side.flyOffset(size: cell.frame.size)
            let transitionDelay = (cell.isSelected ? 0.0 : touchDelay) + (delay * Double(index + 1))
            
            cell.layer.zPosition = CGFloat(sortedCells.count - index)
            
            UIView.animate(withDuration: tileTransitionDuration, delay: transitionDelay, options: .curveEaseIn, animations: {
                cell.transform = CGAffineTransform(translationX: cellOffset.width, y: cellOffset.height)
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 0.29,
                       delay: self.transitionDuration(using: context) - 0.29,
                       options: .curveEaseOut,
                       animations: {
                        fromViewController.view.alpha = 0
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
        
        let sortedCells = collectionView.visibleCells.sorted { (cell1, cell2) -> Bool in
            let side = collectionView.side(for: cell1)
            return !side.isAtBorder()
        }
        
        for (index, cell) in sortedCells.enumerated() {
            let transitionDelay = 0.29 + (delay * Double(index))
            
            UIView.animate(withDuration: tileTransitionDuration, delay: transitionDelay, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: { (completed) in
                if index == sortedCells.count - 1 {
                    context.completeTransition(completed)
                }
            })
        }
        
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseIn, animations: {
            fromViewController.view.alpha = 0
            toViewController.view.alpha = 1
        }, completion: nil)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
