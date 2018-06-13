//
//  FlyAnimator.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class DoubleFlyAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    let delay = 0.02
    let touchDelay = 0.15
    let tileTransitionDuration = 0.16
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animateIn(context: transitionContext)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateIn(context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from) as? UICollectionViewController,
            let toViewController = context.viewController(forKey: .to) as? UICollectionViewController,
            let fromCollectionView = fromViewController.collectionView,
            let toCollectionView = toViewController.collectionView else { return }

        toCollectionView.layoutSubviews()
    
        containerView.removeConstraints(containerView.constraints)
        containerView.insertSubview(toViewController.view, at: 0)
        containerView.insertSubview(fromViewController.view, at: 3)

        // From Cells
        let fromSortedCells = fromCollectionView.visibleCells.sorted { (cell1, cell2) -> Bool in
            if cell1.isSelected { return true }
            if cell2.isSelected { return false }
            
            let side = fromCollectionView.side(for: cell1)
            return side.isAtBorder()
        }
        
        for (index, cell) in fromSortedCells.enumerated() {
            let side = fromCollectionView.side(for: cell)
            let cellOffset = side.flyOffset(size: cell.frame.size)
            let transitionDelay = (cell.isSelected ? 0.0 : touchDelay) + (delay * Double(index + 1))
            
            cell.layer.zPosition = CGFloat(fromSortedCells.count - index)
            
            UIView.animate(withDuration: tileTransitionDuration, delay: transitionDelay, options: .curveEaseIn, animations: {
                cell.transform = CGAffineTransform(translationX: cellOffset.width, y: cellOffset.height)
            }, completion: nil)
        }
        
        fromViewController.view.alpha = 1

        // To Cells
        let toSortedCells = toCollectionView.visibleCells.sorted { (cell1, cell2) -> Bool in
            if cell1.isSelected { return true }
            if cell2.isSelected { return false }

            let side = toCollectionView.side(for: cell1)
            return side.isAtBorder()
        }.reversed()

        for (index, cell) in toSortedCells.enumerated() {
            let side = toCollectionView.side(for: cell)
            let cellOffset = side.flyOffset(size: cell.frame.size)
            let transitionDelay = 0.6 + (cell.isSelected ? 0.0 : touchDelay) + (delay * Double(index + 1))

            cell.layer.zPosition = CGFloat(toSortedCells.count - index)
            cell.transform = CGAffineTransform(translationX: cellOffset.width, y: cellOffset.height)

            UIView.animate(withDuration: tileTransitionDuration, delay: transitionDelay, options: .curveEaseOut, animations: {
                cell.transform = .identity
            }, completion: { completed in
                if index == toSortedCells.count - 1 {
                    context.completeTransition(completed)
                }
            })
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
