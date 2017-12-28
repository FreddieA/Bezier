//
//  ChartView.swift
//
//  Created by Mikhail Kirillov on 27/12/2017.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import UIKit

enum ChartType {
    case curve
    case bars
}

class ChartView: UIView {
    var gridView: GridView
    var graphView: UIView

    func show(with chartType: ChartType) {
        switch chartType {
        case .curve:
            graphView = BezierCurveView(frame: gridView.usableSpace(), points: [])
        case .bars:
            var points: [Float] = []
            for i in 0..<100 {
                points.append(Float(i))
            }
            graphView = BarView(frame: gridView.usableSpace(), points: points)
        }
    }

    override init(frame: CGRect) {
        gridView = GridView(frame: frame)
        graphView = UIView(frame: gridView.usableSpace())
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        gridView = GridView(frame: CGRect.zero)
        graphView = UIView(frame: CGRect.zero)
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if gridView.superview == nil {
            self.addSubview(gridView)
        }
        if graphView.superview == nil {
            gridView.addSubview(graphView)
        }
        gridView.frame = self.bounds
        graphView.frame = gridView.usableSpace()

        gridView.setNeedsDisplay()
        graphView.setNeedsDisplay()
    }
}
