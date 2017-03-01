//
//  BarViewController.swift
//  Twinmax
//
//  Created by Annihil on 10/19/16.
//  Copyright © 2016 ISEN. All rights reserved.
//

import UIKit
import Charts

class BarViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    
    let averageSize = 200
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(generateGraph), userInfo: nil, repeats: true)
        
        barChartView.noDataText = "Données non disponibles"
        barChartView.chartDescription?.text = ""
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.axisMinimum = -0.5;
        barChartView.xAxis.axisMaximum = 3.5
        barChartView.leftAxis.axisMinimum = 430
        barChartView.leftAxis.axisMaximum = 1350
        
        generateGraph()
    }

    func generateGraph() {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<4 {
            if cylinders[i].count > 0 {
                var avg = 0.0
                if cylinders[i].count > averageSize {
                    let slice = cylinders[i][cylinders[i].count-averageSize..<cylinders[i].count]
                    avg = Double(slice.reduce(0, +)) / Double(averageSize)
                }
                else {
                    avg = Double(cylinders[i].reduce(0, +)) / Double(cylinders[i].count)
                }
  
                let dataEntry = BarChartDataEntry(x: Double(i), y: avg)
                dataEntries.append(dataEntry)
            }
        }
        
        if dataEntries.count > 0 {
            let chartDataSet = BarChartDataSet(values: dataEntries, label: "mbar")
            chartDataSet.setColor(NSUIColor.orange)
            let chartData = BarChartData(dataSet: chartDataSet)
            barChartView.data = chartData
        }
    }
}
