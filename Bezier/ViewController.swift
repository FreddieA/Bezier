//
//  ViewController.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/12/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var firstBezierView: BezierView!
    
    let dataPoints = [145, 1, 44, 2, 45, 12, 9, 56, 84, 34, 90]
    
    var xAxisPoints : [Double] {
        var points = [Double]()
        for i in 0..<dataPoints.count {
            let val = (Double(i) / Double(dataPoints.count - 1)) * self.firstBezierView.frame.width.f
            points.append(val)
        }
        
        return points
    }
    
    var yAxisPoints: [Double] {
        var points = [Double]()
        for i in dataPoints {
            let val = (Double(i) / Double(dataPoints.max()!)) * self.firstBezierView.frame.height.f
            points.append(val)
        }
        return points
    }
    
    var graphPoints : [CGPoint] {
        var points = [CGPoint]()
        for i in 0..<dataPoints.count {
            let val = CGPoint(x: self.xAxisPoints[i], y: self.yAxisPoints[i])
            points.append(val)
        }
        
        return points
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstBezierView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.firstBezierView.layoutSubviews()
    }
}

extension ViewController: BezierViewDataSource {
    
    func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint] {
        
        return graphPoints
    }
}

