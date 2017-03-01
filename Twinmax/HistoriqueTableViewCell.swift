//
//  HistoriqueTableViewCell.swift
//  Twinmax
//
//  Created by Baptiste KAROLEWSKI on 22/09/2016.
//  Copyright © 2016 ISEN. All rights reserved.
//

import UIKit

class HistoriqueTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var photo: UIImageView?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel! 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
