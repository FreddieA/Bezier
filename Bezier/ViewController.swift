//
//  ViewController.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/12/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //@IBOutlet weak var firstBezierView: BezierView!
    
    //let dataPoints : [CGFloat] = [0.1, 0.5, 0.44, 0.2, 0.5, 0.12, 0.9, 0.56, 0.84, 0.34, 0.9]
    let dataPoints : [CGFloat] = [1, 5, 44, 2, 5, 12, 9, 56, 84, 34, 9]
    
//    var xAxisPoints : [Double] {
//        var points = [Double]()
//        for i in 0..<dataPoints.count {
//            let val = (Double(i) / Double(dataPoints.count - 1)) * self.firstBezierView.frame.width.f
//            points.append(val)
//        }
//
//        return points
//    }
//
//    var yAxisPoints: [Double] {
//        var points = [Double]()
//        for i in dataPoints {
//            let val = self.firstBezierView.frame.height.f - self.firstBezierView.frame.height.f / ( Double(dataPoints.max()!) / Double(i))
//            points.append(val)
//        }
//        return points
//    }
//
//    var graphPoints : [CGPoint] {
//        var points = [CGPoint]()
//        for i in 0..<dataPoints.count {
//            let val = CGPoint(x: self.xAxisPoints[i], y: self.yAxisPoints[i])
//            points.append(val)
//        }
//
//        return points
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        firstBezierView.dataSource = self
//    }
}

