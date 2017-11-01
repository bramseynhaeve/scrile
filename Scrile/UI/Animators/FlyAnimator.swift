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
    let topBlackView = UIView()
    let bottomBlackView = UIView()
    
    override init() {
        super.init()
        
        topBlackView.backgroundColor = .black
        topBlackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBlackView.backgroundColor = .black
        bottomBlackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
              let toViewController = context.viewController(forKey: .to),
              let collectionView = fromViewController.collectionView else { return }
    
        containerView.insertSubview(toViewController.view, at: 0)
        containerView.insertSubview(topBlackView, at:1)
        containerView.insertSubview(bottomBlackView, at: 2)
        containerView.insertSubview(fromViewController.view, at: 3)
        
        let topWidthConstraints = NSLayoutConstraint(item: topBlackView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let topHeightConstraints = NSLayoutConstraint(item: topBlackView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0.5, constant: 0.0)
        let topHorizontalConstraint = NSLayoutConstraint(item: topBlackView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topVerticalConstraint = NSLayoutConstraint(item: topBlackView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        let bottomWidthConstraints = NSLayoutConstraint(item: bottomBlackView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let bottomHeightConstraints = NSLayoutConstraint(item: bottomBlackView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0.5, constant: 0.0)
        let bottomHorizontalConstraint = NSLayoutConstraint(item: bottomBlackView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let bottomVerticalConstraint = NSLayoutConstraint(item: bottomBlackView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        containerView.addConstraints([topWidthConstraints, topHeightConstraints, topHorizontalConstraint, topVerticalConstraint])
        containerView.addConstraints([bottomWidthConstraints, bottomHeightConstraints, bottomHorizontalConstraint, bottomVerticalConstraint])
        
        containerView.layoutIfNeeded()
        
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
                       delay: self.transitionDuration(using: context) * 0.4,
                       options: .curveEaseOut,
                       animations: {
                        self.topBlackView.transform = CGAffineTransform(translationX: 0, y: -self.topBlackView.frame.height)
                        self.bottomBlackView.transform = CGAffineTransform(translationX: 0, y: self.bottomBlackView.frame.height)
        }) { (completed) in
            context.completeTransition(completed)
        }
    }
    
    func animateOut(context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from),
            let toViewController = context.viewController(forKey: .to) as? UICollectionViewController,
            let collectionView = toViewController.collectionView else { return }
        
        containerView.insertSubview(fromViewController.view, at: 0)
        containerView.insertSubview(topBlackView, at:1)
        containerView.insertSubview(bottomBlackView, at: 2)
        containerView.insertSubview(toViewController.view, at: 3)
        
        let sortedCells = collectionView.visibleCells.sorted { (cell1, cell2) -> Bool in
            let side = collectionView.side(for: cell1)
            return !side.isAtBorder()
        }
        
        let defaultDelay = self.transitionDuration(using: context) * 0.2
        for (index, cell) in sortedCells.enumerated() {
            let transitionDelay = defaultDelay + (delay * Double(index))
            
            UIView.animate(withDuration: tileTransitionDuration, delay: transitionDelay, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: { (completed) in
                if index == sortedCells.count - 1 {
                    context.completeTransition(completed)
                }
            })
        }
        
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
            self.topBlackView.transform = CGAffineTransform.identity
            self.bottomBlackView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
