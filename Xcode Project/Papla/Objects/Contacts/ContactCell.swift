//
//  Contact.swift
//  Papla
//
//  Created by Dario Leunig on 15.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameButton: UIButton!
    var contactId: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showContact(_ sender: Any) {
    }
    
}
