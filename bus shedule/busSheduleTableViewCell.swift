//
//  busSheduleTableViewCell.swift
//  Ecopedia_MVP
//
//  Created by Anatoliy Anatolyev on 17.04.2019.
//  Copyright © 2019 Valeriy. All rights reserved.
//

import UIKit

class busSheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var busyView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
