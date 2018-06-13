//
//  FlipAnimator.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

private let perspective: CGFloat = -1/1000.0;

class FlipAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isInAnimation(context: transitionContext) {
            flipTiles(reverseAnimation: false, context: transitionContext)
        } else {
            flipTiles(reverseAnimation: true, context: transitionContext)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func isInAnimation(context: UIViewControllerContextTransitioning) -> Bool {
        guard let fromViewController = context.viewController(forKey: .from) else { return true }
        return fromViewController.isKind(of: TileCollectionViewController.self)
    }
    
    func flipTiles(reverseAnimation: Bool, context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from) as? UICollectionViewController,
            let toViewController = context.viewController(forKey: .to) as? UICollectionViewController,
            let fromCollectionView = fromViewController.collectionView,
            let toCollectionView = toViewController.collectionView else { return }
        
        containerView.insertSubview(toViewController.view, at: 0)
        containerView.insertSubview(fromViewController.view, at: 1)
        
        toCollectionView.contentOffset = fromCollectionView.contentOffset
        toCollectionView.layoutSubviews()

        if let resultViewController = toViewController as? ResultCollectionViewController {
            resultViewController.resultView.alpha = 0

            UIView.animate(withDuration: 1) {
                resultViewController.resultView.alpha = 1
            }
        }

        let fromVisibleCells = fromCollectionView.visibleCells.sorted { (cell1, cell2) -> Bool in
        
            if cell1.isSelected { return true }
            if cell2.isSelected { return false }
        
            guard let indexPath1 = fromCollectionView.indexPath(for: cell1),
                let indexPath2 = fromCollectionView.indexPath(for: cell2) else { return false }
            
            var bool = false
            if indexPath1.section == indexPath2.section {
                bool = indexPath1.row < indexPath2.row
            } else {
                bool = indexPath1.section < indexPath2.section
            }
            
            if reverseAnimation { bool = !bool }
            
            return bool
        }
        
        let rotationFactor: CGFloat = reverseAnimation ? -1 : 1
        
        var fromTransform = CATransform3DIdentity
        fromTransform.m34 = perspective
        fromTransform = CATransform3DRotate(fromTransform, (CGFloat.pi * rotationFactor)  / 2, 0, 1, 0)
        
        var toTransform = CATransform3DIdentity
        toTransform.m34 = perspective
        toTransform = CATransform3DRotate(toTransform, -(CGFloat.pi * rotationFactor) / 2, 0, 1, 0)
        
        for (index, cell) in fromVisibleCells.enumerated() {
            
            guard let toIndexPath = toCollectionView.indexPathForItem(at: cell.center),
                let toCell = toCollectionView.cellForItem(at: toIndexPath) else { return }
            
            toCell.layer.transform = toTransform
            
            let firstCellDelay = index == 0 ? 0.0 : 0.1
            
            UIView.animate(withDuration: 0.15, delay: 0.02 * Double(index) + firstCellDelay, options: .curveEaseIn, animations: {
                cell.layer.transform = fromTransform
            }) { (completed) in
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
                    toCell.layer.transform = CATransform3DIdentity
                }) { (completed) in
                    if index == fromCollectionView.visibleCells.count - 1 {
                        context.completeTransition(completed)
                    }
                }
            }
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
