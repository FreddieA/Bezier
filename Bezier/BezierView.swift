//
//  BezierView.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/14/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit
import Foundation

protocol BezierViewDataSource: class {
    func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint]
}

class BezierView: UIView {
   
    private let kStrokeAnimationKey = "StrokeAnimationKey"
    private let kFadeAnimationKey = "FadeAnimationKey"

    weak var dataSource: BezierViewDataSource?

    var animates = true
    
    var pointLayers = [CAShapeLayer]()
    var lineLayer = CAShapeLayer()
    
    private var dataPoints: [CGPoint]? {
        return self.dataSource?.bezierViewDataPoints(bezierView: self)
    }
    
    private let cubicCurveAlgorithm = CubicCurveAlgorithm()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.sublayers?.forEach({ (layer: CALayer) -> () in
            layer.removeFromSuperlayer()
        })
        pointLayers.removeAll()
        
        drawLines()
        drawPoints()
    }
    
    private func drawPoints() {
        
        guard let points = dataPoints else {
            return
        }
        for point in points {
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 4, height: 4)
            circleLayer.path = UIBezierPath(ovalIn: circleLayer.bounds).cgPath
            circleLayer.fillColor = UIColor.white.cgColor
            circleLayer.strokeColor = UIColor.black.cgColor
            circleLayer.position = point
            self.layer.addSublayer(circleLayer)
        }
    }
    
    func move(point: CGPoint) -> CGPoint  {
        let frame = self.frame
        var newPoint = CGPoint.zero
        newPoint.x = min(point.x, frame.width)
        newPoint.x = max(newPoint.x, frame.origin.x)
        
        newPoint.y = min(point.y, frame.height)
        newPoint.y = max(newPoint.y, frame.origin.y)
        return newPoint
    }
    
    private func drawLines() {
        
        guard let points = dataPoints else {
            return
        }

        let controlPoints = cubicCurveAlgorithm.controlPointsFromPoints(dataPoints: points)
        let linePath = UIBezierPath()

        for (i, point) in points.enumerated() {
            if i == 0 {
                linePath.move(to: point)
            } else {
                let segment = controlPoints[i-1]
                linePath.addCurve(to: point, controlPoint1: move(point: segment.controlPoint1), controlPoint2: move(point: segment.controlPoint2))
            }
        }
        
        lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 1.0
        
        self.layer.addSublayer(lineLayer)
    }
}

