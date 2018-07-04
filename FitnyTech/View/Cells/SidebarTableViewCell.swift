//
//  SidebarTableViewCell.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 02/07/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit

class SidebarTableViewCell: UITableViewCell {

	@IBOutlet weak var itemNameLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
