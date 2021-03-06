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
        return fromViewController.isKind(of: TileCollectionViewController.self)
    }
    
    func animateIn(context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from) as? UICollectionViewController,
              let toViewController = context.viewController(forKey: .to),
              let collectionView = fromViewController.collectionView else { return }
    
        containerView.removeConstraints(containerView.constraints)
        containerView.insertSubview(toViewController.view, at: 0)
        containerView.insertSubview(topBlackView, at:1)
        containerView.insertSubview(bottomBlackView, at: 2)
        containerView.insertSubview(fromViewController.view, at: 3)

        topBlackView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        topBlackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        topBlackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        topBlackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        bottomBlackView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        bottomBlackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        bottomBlackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bottomBlackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        containerView.layoutIfNeeded()
        
        self.topBlackView.transform = CGAffineTransform.identity
        self.bottomBlackView.transform = CGAffineTransform.identity
        
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
        
        fromViewController.view.alpha = 1
        toViewController.view.alpha = 0

        UIView.animate(withDuration: 0.29,
                       delay: self.transitionDuration(using: context) * 0.4,
                       options: .curveEaseOut,
                       animations: {
//                            fromViewController.view.alpha = 0
                            toViewController.view.alpha = 1
                            self.topBlackView.transform = CGAffineTransform(translationX: 0, y: -self.topBlackView.frame.height)
                            self.bottomBlackView.transform = CGAffineTransform(translationX: 0, y: self.bottomBlackView.frame.height)
        }) { (completed) in
            self.topBlackView.removeFromSuperview()
            self.bottomBlackView.removeFromSuperview()
            context.completeTransition(completed)
        }
    }
    
    func animateOut(context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        guard let fromViewController = context.viewController(forKey: .from),
            let toViewController = context.viewController(forKey: .to) as? UICollectionViewController,
            let collectionView = toViewController.collectionView else { return }
        
        containerView.removeConstraints(containerView.constraints)
        containerView.insertSubview(fromViewController.view, at: 0)
        containerView.insertSubview(topBlackView, at:1)
        containerView.insertSubview(bottomBlackView, at: 2)
        containerView.insertSubview(toViewController.view, at: 3)

        topBlackView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        topBlackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        topBlackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        topBlackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        bottomBlackView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        bottomBlackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        bottomBlackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bottomBlackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        containerView.layoutIfNeeded()
        
        self.topBlackView.transform = CGAffineTransform(translationX: 0, y: -self.topBlackView.frame.height)
        self.bottomBlackView.transform = CGAffineTransform(translationX: 0, y: self.bottomBlackView.frame.height)

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
                    self.topBlackView.removeFromSuperview()
                    self.bottomBlackView.removeFromSuperview()
                    context.completeTransition(completed)
                }
            })
        }

        toViewController.view.alpha = 1
        fromViewController.view.alpha = 1
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
