//
//  BezierCurveView.swift
//
//  Created by Mikhail Kirillov on 27/12/2017.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import UIKit
import Foundation

struct DataPoint {
    let value: Float
    let timeUnit: Int
}

class BezierCurveView: UIView {
   
    private let kStrokeAnimationKey = "StrokeAnimationKey"
    private let kFadeAnimationKey = "FadeAnimationKey"
    private let cubicCurveAlgorithm = CubicCurveAlgorithm()
    private var valuePoints = [Float]()

    var pointLayers = [CAShapeLayer]()
    var lineLayer = CAShapeLayer()

    func setData(points: [DataPoint]) {

    valuePoints = points.map({ (dataPoint) -> Float in
            return dataPoint.value
        })
    }

    var xAxisPoints : [CGFloat] {
        var points = [CGFloat]()
        for i in 0..<valuePoints.count {
            let val = (CGFloat(i) / CGFloat(valuePoints.count - 1)) * self.frame.width
            points.append(val)
        }
        return points
    }

    var yAxisPoints: [CGFloat] {
        var points = [CGFloat]()
        for i in valuePoints {
            let val = self.frame.height - self.frame.height / ( CGFloat(valuePoints.max()!) / CGFloat(i))
            points.append(val)
        }
        return points
    }

    var graphPoints : [CGPoint]? {
        var points = [CGPoint]()
        for i in 0..<valuePoints.count {
            let val = CGPoint(x: xAxisPoints[i], y: yAxisPoints[i])
            points.append(val)
        }

        return points
    }

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
        
        guard let points = graphPoints else {
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
        
        guard let points = graphPoints else {
            return
        }
        let controlPoints = cubicCurveAlgorithm.controlPointsFromPoints(dataPoints: points)
        let linePath = UIBezierPath()

        for (i, point) in points.enumerated() {
            if i == 0 {
                linePath.move(to: point)
            } else {
                let segment = controlPoints[i - 1]
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

