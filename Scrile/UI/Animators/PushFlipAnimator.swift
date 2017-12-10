//
//  PushFlipAnimator.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class PushFlipAnimator: FlipAnimator {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        flipTiles(reverseAnimation: false, context: transitionContext)
    }
}
