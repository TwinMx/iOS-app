//
//  GraphViewController.swift
//  Twinmax
//
//  Created by Nicolas Creton on 27/09/2016.
//  Copyright © 2016 ISEN. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {
    
    // MARK Constants
    let stringStart: String = "Connectez vous à TwinMax pour générer un graphique"
    let stringSelect: String = "Vous n'avez pas sélectionné de cylindre à mesurer"
    let pointSize: Int = 100
    
    // MARK Variables
    var dataSets = [LineChartDataSet]()
    
    // MARK Properties
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet var buttonAction: [UICheckbox]!
    
    @IBAction func touchUpInsideAction(_ sender: UIButton) {
        dataSets[sender.tag].visible = !sender.isSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(generateGraph), name: NSNotification.Name(rawValue: newDataAvailable), object: nil)
        
        lineChartView.noDataText = stringStart
        lineChartView.chartDescription?.text = ""
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawLabelsEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.axisMinimum = 300
        lineChartView.leftAxis.axisMaximum = 1200
        
        dataSets.append(LineChartDataSet(values: nil, label: ""))
        dataSets.append(LineChartDataSet(values: nil, label: ""))
        dataSets.append(LineChartDataSet(values: nil, label: ""))
        dataSets.append(LineChartDataSet(values: nil, label: ""))
        dataSets[0].setColor(NSUIColor.orange)
        dataSets[0].drawCirclesEnabled = false
        dataSets[1].setColor(NSUIColor.blue)
        dataSets[1].drawCirclesEnabled = false
        dataSets[2].setColor(NSUIColor.green)
        dataSets[2].drawCirclesEnabled = false
        dataSets[3].setColor(NSUIColor.red)
        dataSets[3].drawCirclesEnabled = false
    }
    
    func generateGraph() {
        for i in 0..<4 {
            if cylinders[i].count > 0 {
                if cylinders[i].count > pointSize {
                    let slice = cylinders[i][cylinders[i].count-pointSize..<cylinders[i].count]
                    dataSets[i].clear()
                    for (index, element) in slice.enumerated() {
                        _ = dataSets[i].addEntry(ChartDataEntry(x: Double(index), y: element))
                    }
//                    dataSets[i].notifyDataSetChanged()
                }
            }
        }
        
        if dataSets[0].entryCount > 0 {
            if lineChartView.data == nil {
                lineChartView.data = LineChartData(dataSets: dataSets)
            }
            
            lineChartView.moveViewToX(Double(dataSets[0].entryCount))
        }
    }
}
