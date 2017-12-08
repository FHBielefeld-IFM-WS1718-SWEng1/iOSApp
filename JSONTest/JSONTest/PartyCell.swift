//
//  PartyList.swift
//  JSONTest
//
//  Created by Dario Leunig on 08.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class PartyCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var whoLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var imgImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
