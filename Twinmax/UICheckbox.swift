//
//  UICheckbox.swift
//  Twinmax
//
//  Created by Annihil on 10/22/16.
//  Copyright © 2016 ISEN. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class UICheckbox: UIButton {
    // Images
    @IBInspectable var selectedImage: UIImage?
    @IBInspectable var unselectedImage: UIImage?
    
    // Bool Property
    override var isSelected: Bool{
        didSet {
            if isSelected {
                self.setImage(selectedImage, for: UIControlState.normal)
            } else {
                self.setImage(unselectedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.isSelected = !(!isSelected)
        self.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.adjustsImageWhenHighlighted = false
    }
    
    func buttonClicked(sender: UIButton) {
        self.isSelected = !self.isSelected
    }
}
