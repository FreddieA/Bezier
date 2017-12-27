//
//  GraphView.swift
//
//  Created by Mikhail Kirillov on 27/12/2017.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import UIKit

class GraphView: UIView {
    var grid: GraphGridView?
    var curve: BezierCurveView?

    override init(frame: CGRect) {
        super.init(frame: frame)

        grid = GraphGridView.init(frame: frame)
        curve = BezierCurveView.init(frame: grid!.usableSpace())

        self.addSubview(grid!)
        self.addSubview(curve!)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        grid = GraphGridView.init(frame: self.bounds)
        curve = BezierCurveView.init(frame: grid!.usableSpace())

        self.addSubview(grid!)
        self.addSubview(curve!)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
