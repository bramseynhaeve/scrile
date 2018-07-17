//
//  ColorViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

protocol ColorDelegate: AnyObject {
    func didChooseColor(color: UIColor)
}

class ColorViewController: UIViewController {

    fileprivate let colorCircle = UIView()
    fileprivate let okButton = UIButton()
    fileprivate let scrubber = UIView()
    fileprivate let line = Line(startPoint: .zero, endPoint: .zero)
    fileprivate let brightnessButton = UIView()
    fileprivate let colorNameLabel = UILabel()
    fileprivate let touchCircleRadius: CGFloat = 70
    fileprivate var scrubberXPosition: NSLayoutConstraint?
    fileprivate var scrubberYPosition: NSLayoutConstraint?
    fileprivate var brightnessButtonXPosition: NSLayoutConstraint?
    fileprivate var brightnessButtonYPosition: NSLayoutConstraint?
    fileprivate let startColor: UIColor
    fileprivate var currentColor: UIColor

    weak var delegate: ColorDelegate?

    init(color: UIColor) {
        startColor = color
        currentColor = startColor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        colorCircle.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        scrubber.translatesAutoresizingMaskIntoConstraints = false
        colorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        brightnessButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(colorCircle)
        view.addSubview(line)
        view.addSubview(okButton)
        view.addSubview(scrubber)
        view.addSubview(colorNameLabel)
        view.addSubview(brightnessButton)

        let okButtonRadius:CGFloat = 25.0
        okButton.widthAnchor.constraint(equalToConstant: okButtonRadius * 2).isActive = true
        okButton.heightAnchor.constraint(equalTo: okButton.widthAnchor).isActive = true
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        okButton.setBackgroundImage(UIColor.white.image, for: .normal)
        okButton.setBackgroundImage(UIColor.white.withAlphaComponent(0.6).image, for: .highlighted)
        okButton.setTitle("color_button_ok".localized, for: .normal)
        okButton.addTarget(self, action: #selector(self.didTouchBackButton), for: .touchUpInside)
        okButton.titleLabel?.font = UIFont.font1Bold(size: 22)
        okButton.layer.cornerRadius = okButtonRadius
        okButton.clipsToBounds = true

        let colorCircleDiameterWithBorder = (touchCircleRadius + 2.5) * 2
        colorCircle.widthAnchor.constraint(equalToConstant: colorCircleDiameterWithBorder).isActive = true
        colorCircle.heightAnchor.constraint(equalTo: colorCircle.widthAnchor).isActive = true
        colorCircle.centerXAnchor.constraint(equalTo: okButton.centerXAnchor).isActive = true
        colorCircle.centerYAnchor.constraint(equalTo: okButton.centerYAnchor).isActive = true
        colorCircle.layer.borderColor = UIColor.white.cgColor
        colorCircle.layer.borderWidth = 5
        colorCircle.layer.cornerRadius = colorCircleDiameterWithBorder / 2
        colorCircle.alpha = 0.4

        let scrubberRadius: CGFloat = 15.0
        scrubberXPosition = scrubber.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        scrubberYPosition = scrubber.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        scrubberXPosition?.isActive = true
        scrubberYPosition?.isActive = true

        let borderWidth: CGFloat = 3.0
        let scrubberWidth = (scrubberRadius * 2) - borderWidth
        scrubber.widthAnchor.constraint(equalToConstant: scrubberWidth).isActive = true
        scrubber.heightAnchor.constraint(equalTo: scrubber.widthAnchor).isActive = true
        scrubber.backgroundColor = UIColor.white
        scrubber.layer.cornerRadius = scrubberWidth / 2
        scrubber.layer.borderWidth = borderWidth
        scrubber.layer.borderColor = UIColor.white.cgColor

        brightnessButtonXPosition = brightnessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        brightnessButtonYPosition = brightnessButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        brightnessButtonXPosition?.isActive = true
        brightnessButtonYPosition?.isActive = true
        brightnessButton.widthAnchor.constraint(equalToConstant: 10).isActive = true
        brightnessButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        brightnessButton.backgroundColor = UIColor.white
        brightnessButton.layer.cornerRadius = 5

        colorNameLabel.textAlignment = .center
        colorNameLabel.font = UIFont.font1Medium(size: 25)
        colorNameLabel.textColor = UIColor.white
        colorNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        colorNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true

        moveScrubber(color: startColor)
        updateColor(color: startColor)
        updateBrightnessButton(color: startColor)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        line.startPoint = scrubber.layer.position
        line.endPoint = brightnessButton.layer.position
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newColor = colorInfo(touch: touch, inView: view)

        line.animateIn()
        moveScrubber(color: newColor)
        updateBrightnessButton(color: newColor)
        updateColor(color: newColor, isTouching: true)

        let duration = 0.53
        let delay = 0.0
        let damping: CGFloat = 0.4
        let velocity: CGFloat = 2.0

        UIView.animate(withDuration: duration / 4, delay: delay, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.scrubber.backgroundColor = newColor
        }, completion: nil)

        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.scrubber.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newColor = colorInfo(touch: touch, inView: view)

        moveScrubber(color: newColor)
        updateColor(color: newColor, isTouching: true)
        updateBrightnessButton(color: newColor)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newColor = colorInfo(touch: touch, inView: view)

        line.animateOut()
        moveScrubber(color: newColor)
        updateBrightnessButton(color: newColor)
        updateColor(color: newColor, isTouching: true)

        let duration = 0.53
        let delay = 0.0
        let damping: CGFloat = 0.4
        let velocity: CGFloat = 2.0

        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.scrubber.transform = CGAffineTransform.identity
                        self.scrubber.backgroundColor = UIColor.white
        }, completion: nil)
    }

    // ---------------

    func scrubberPosition(forAngle angle: CGFloat, fromCenter center: CGPoint) -> CGPoint {
        return center.point(angle: angle, distance: touchCircleRadius)
    }

    func relativeScrubberPosition(forAngle angle: CGFloat) -> CGPoint {
        let center = view.center
        let newPosition = scrubberPosition(forAngle: angle, fromCenter: center)
        return CGPoint(x: newPosition.x - center.x, y: newPosition.y - center.y)
    }

    func moveScrubber(color: UIColor) {
        let relativePosition = relativeScrubberPosition(forAngle: color.angle())
        scrubberXPosition?.constant = relativePosition.x
        scrubberYPosition?.constant = relativePosition.y
    }

    func updateColor(color: UIColor, isTouching: Bool = false) {
        scrubber.backgroundColor = isTouching ? color : UIColor.white
        okButton.setTitleColor(color, for: .normal)
        view.backgroundColor = color
        colorNameLabel.text = color.name()
        currentColor = color
    }

    func updateBrightnessButton(color: UIColor) {
        let center = view.center
        let angle = color.angle()
        let borderPoint = view.frame.borderPoint(for: angle)
        let scrubberPoint = scrubberPosition(forAngle: angle, fromCenter: center)
        let maxDistance = scrubberPoint.distance(borderPoint)
        let currentDistance = maxDistance * color.brightnessFactor()
        let point = scrubberPoint.point(angle: angle, distance: currentDistance)

        brightnessButtonXPosition?.constant = point.x - center.x
        brightnessButtonYPosition?.constant = point.y - center.y
    }

    // --------------

    func colorInfo(touch: UITouch, inView view: UIView) -> UIColor {
        let touchPosition = touch.location(in: view)
        let centerPoint = view.frame.center
        let colorBrightness = touchProgressToBorder(point: touchPosition, rect: view.frame)
        let angle = centerPoint.angle(touchPosition)
        let color = UIColor(angle: angle, brightnessFactor: colorBrightness)

        return color
    }

    func touchProgressToBorder(point: CGPoint, rect: CGRect) -> CGFloat {
        let angle = rect.center.angle(point)
        let distanceToBorder = rect.distanceToBorder(forAngle: angle) - touchCircleRadius
        let touchDistance = point.distance(rect.center) - touchCircleRadius

        let brightness = max(0, touchDistance / distanceToBorder)
        return brightness
    }
    
    @objc func didTouchBackButton() {
        delegate?.didChooseColor(color: currentColor)
    }
}

private extension UIColor {
    convenience init(angle: CGFloat, brightnessFactor: CGFloat) {
        let colorInfo = UIColor.tile.hsba()
        let saturation = colorInfo.saturation
        let brightness = colorInfo.brightness
        let doublePi: CGFloat = CGFloat.pi * 2
        let positiveAngle = angle + CGFloat.pi
        let adjustedBrightness = 0.7 + ((1 - brightnessFactor) * 0.5)

        let newColorBrightness = brightness * adjustedBrightness

        self.init(hue: positiveAngle / doublePi, saturation: saturation, brightness: newColorBrightness, alpha: 1.0)
    }

    func angle() -> CGFloat {
        let hue = hsba().hue
        let radianHue = (hue * CGFloat.pi * 2) - CGFloat.pi

        return radianHue
    }

    func brightnessFactor() -> CGFloat {
        let tileInfo = UIColor.tile.hsba()
        let brightness = tileInfo.brightness

        let currentInfo = hsba()
        let adjustedBrightness = currentInfo.brightness / brightness
        let brightnessFactor = max(0 , min(1, -(((adjustedBrightness - 0.7) / 0.5) - 1)))

        return brightnessFactor
    }
}
