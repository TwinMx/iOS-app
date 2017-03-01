//
//  Mesure.swift
//  Twinmax
//
//  Created by Baptiste KAROLEWSKI on 21/09/2016.
//  Copyright Â© 2016 ISEN. All rights reserved.
//

import UIKit

class Mesure{
    // MARK: Properties
    
    var name: String
    var date: String
    var photo: UIImage
    var note: String
    
    // MARK: Initialization
    
    init?(name: String, date: String, photo: UIImage?, note: String?) {
        self.name = name 
        self.date = date
        self.photo = photo!
        self.note = note!
        
        if name.isEmpty {
            return nil
        }
    }
}
