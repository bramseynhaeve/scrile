//
//  PopFlyAnimator.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class PopFlyAnimator: FlyAnimator {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animateOut(context: transitionContext)
    }
}
