//
//  BarView.swift
//  Bezier
//
//  Created by Mikhail Kirillov on 28/12/2017.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import UIKit

class BarView: UIStackView {

    var points: [CGFloat] = []

    init(frame: CGRect, points: [Float]) {
        self.points = points.map {CGFloat($0)}
        super.init(frame: frame)

        self.axis = UILayoutConstraintAxis.horizontal
        self.preservesSuperviewLayoutMargins = true
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.isLayoutMarginsRelativeArrangement = true
        self.distribution = .fillEqually
        //self.spacing = 15
        self.alignment = .bottom
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let maxValue = points.max()!

        let _ = self.subviews.map { $0.removeFromSuperview() }

        for point in points {
            let view = GradientBarView.init(frame: CGRect(x: 0, y: 0,
                                                          width: 0,
                                                          height: CGFloat(point / maxValue) * self.bounds.height),
                                            fraction: Double(point / maxValue))
            self.addArrangedSubview(view)
        }
    }
}

class GradientBarView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }

    public init(frame: CGRect, fraction: Double) {
        super.init(frame: frame)

        if fraction < 0.5 {
            self.backgroundColor = interpolateColor(startColor: UIColor.green, endColor: UIColor.yellow, fraction: fraction / 0.5)
        } else {
            self.backgroundColor = interpolateColor(startColor: UIColor.yellow, endColor: UIColor.red, fraction: (fraction - 0.5) / 0.5 )
        }
    }

    override var intrinsicContentSize: CGSize {
        return self.frame.size
    }

    func interpolateColor(startColor: UIColor, endColor: UIColor, fraction: Double) -> UIColor {
        let resultRed = startColor.redComponent() + fraction * (endColor.redComponent() - startColor.redComponent())
        let resultGreen = startColor.greenComponent() + fraction * (endColor.greenComponent() - startColor.greenComponent())
        let resultBlue = startColor.blueComponent() + fraction * (endColor.blueComponent() - startColor.blueComponent())
        print(resultRed, resultGreen, resultBlue, fraction)
        return UIColor.init(red: CGFloat(resultRed),
                            green: CGFloat(resultGreen),
                            blue: CGFloat(0), alpha: 1.0)

    }
}

private extension UIColor {
    func redComponent() -> Double {
        return Double(self.cgColor.components![0])
    }
    func greenComponent() -> Double {
        return Double(self.cgColor.components![1])
    }
    func blueComponent() -> Double {
        return Double(self.cgColor.components![2])
    }
}
