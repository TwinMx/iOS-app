//
//  CompteurViewController.swift
//  Twinmax
//
//  Created by Baptiste KAROLEWSKI on 30/09/2016.
//  Copyright © 2016 ISEN. All rights reserved.
//

import UIKit
import GaugeView

class CompteurViewController: UIViewController {
    @IBOutlet fileprivate weak var gaugeView: GaugeView!
    @IBOutlet weak var compteurLabel: UILabel!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialisation
        //gaugeView.percentage = 0
        gaugeView.thickness = 10
        gaugeView.gaugeBackgroundColor = UIColor.lightGray
        //gaugeView.labelFont = UIFont(name: "digital-7", size: 35)
        //gaugeView.gaugeColor = UIColor.green
        gaugeView.labelFont = UIFont.systemFont(ofSize: 40, weight: UIFontWeightThin)
        gaugeView.labelColor = UIColor.black
        gaugeView.labelText = "0 RPM"
        
        //Automatic animation
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(generateGauge), userInfo: nil, repeats: true)
        }
        
    }
    @IBAction func gaugeAnimation(_ sender: AnyObject) {
        generateGauge()
    }
    
    func generateGauge(){
        gaugeView.gaugeColor = UIColor.orange
        let randomValue = arc4random_uniform(100)
        gaugeView.percentage = Float(randomValue)
        gaugeView.labelText = "\(randomValue*40) RPM"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
