//
//  GraphGridView.swift
//
//  Created by Mikhail Kirillov on 27/12/2017.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import UIKit

class GridView: UIView {

    var numberOfHorizontalDashedLines: CGFloat = 3
    var numberOfVerticalDashedLines: CGFloat = 23
    let axisThickness: CGFloat = 6 / UIScreen.main.scale
    let dashThickness: CGFloat = 0.5 * UIScreen.main.scale

    init(lines: Int, rows: Int, frame: CGRect) {
        super.init(frame: frame)

        numberOfHorizontalDashedLines = CGFloat(lines)
        numberOfVerticalDashedLines = CGFloat(rows)

        self.contentMode = .redraw
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func usableSpace() -> CGRect {
        return CGRect.init(x: axisThickness, y: dashThickness,
                           width: self.bounds.width - axisThickness - dashThickness * 2,
                           height: self.bounds.height - axisThickness - dashThickness * 2)
    }

    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.black

        let context = UIGraphicsGetCurrentContext()
        context!.setStrokeColor(UIColor.white.cgColor)
        context?.setLineWidth(axisThickness)
        context?.setLineJoin(CGLineJoin.bevel)

        let xAxisPath = CGMutablePath()
        xAxisPath.move(to: CGPoint(x: 0, y: rect.height - axisThickness / 2))
        xAxisPath.addLine(to: CGPoint(x: rect.width, y: rect.height - axisThickness / 2))
        context!.addPath(xAxisPath)

        let yAxisPath = CGMutablePath()
        yAxisPath.move(to: CGPoint(x: axisThickness / 2, y: 0))
        yAxisPath.addLine(to: CGPoint(x: axisThickness / 2, y: rect.height))
        context!.addPath(yAxisPath)
        context!.strokePath()

        context?.setLineDash(phase: 2, lengths: [2])
        context?.setLineWidth(dashThickness)

        let verticalSegmentWidth: CGFloat = CGFloat((rect.height - axisThickness) / numberOfHorizontalDashedLines)
        for i in 0..<Int(numberOfHorizontalDashedLines) {

            let horizontalDashLinePath = CGMutablePath()
            horizontalDashLinePath.move(to: CGPoint(x: 0, y: verticalSegmentWidth * CGFloat(i)))
            horizontalDashLinePath.addLine(to: CGPoint(x: rect.width, y: CGFloat(verticalSegmentWidth * CGFloat(i))))
            context?.addPath(horizontalDashLinePath)
        }

        let horizontalSegmentWidth: CGFloat = CGFloat((rect.width - axisThickness) / numberOfVerticalDashedLines)
        for i in 1...Int(numberOfVerticalDashedLines) {

            let dashLinePath = CGMutablePath()
            dashLinePath.move(to: CGPoint(x: horizontalSegmentWidth * CGFloat(i) + axisThickness, y: 0))
            dashLinePath.addLine(to: CGPoint(x: horizontalSegmentWidth * CGFloat(i) + axisThickness, y: rect.height))
            context?.addPath(dashLinePath)
        }
        context!.strokePath()
    }
}
