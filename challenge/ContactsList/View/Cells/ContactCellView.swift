//
//  ContactCellView.swift
//  challenge
//
//  Created by admin on 17/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit

class ContactCellView: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
