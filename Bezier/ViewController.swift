//
//  ViewController.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/12/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chart: ChartView!

    override func viewDidLoad() {
        chart.show(with: ChartType.bars)
    }

}

