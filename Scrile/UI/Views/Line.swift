//
//  Line.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 16/07/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

class Line: UIView {
    var startPoint: CGPoint {
        didSet { drawLine() }
    }

    var endPoint: CGPoint {
        didSet { drawLine() }
    }

    fileprivate let line = CAShapeLayer()
    fileprivate let backgroundLine = CAShapeLayer()

    init(startPoint: CGPoint, endPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint

        super.init(frame: .zero)

        line.backgroundColor = UIColor.clear.cgColor
        line.strokeColor = UIColor.white.cgColor
        line.lineWidth = 5.0
        line.lineCap = CAShapeLayerLineCap.round
        line.fillColor = UIColor.clear.cgColor
        line.strokeEnd = 0.0

        backgroundLine.strokeColor = line.strokeColor?.copy(alpha: 0.2)
        backgroundLine.backgroundColor = UIColor.clear.cgColor
        backgroundLine.lineWidth = line.lineWidth
        backgroundLine.fillColor = UIColor.clear.cgColor

        layer.addSublayer(backgroundLine)
        layer.addSublayer(line)
    }

    func animateIn(duration: Double = 0.29) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.repeatCount = 0
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        line.add(animation, forKey: "strokeEnd")
    }

    func animateOut(duration: Double = 0.5) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.repeatCount = 0
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        line.add(animation, forKey: "strokeEnd")
    }

    fileprivate func drawLine()  {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)

        line.path = path.cgPath
        backgroundLine.path = path.cgPath
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
