//
//  TasksViewController.swift
//  Papla
//
//  Created by Dario Leunig on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {    
    @IBOutlet weak var partyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partyView.layer.shadowOpacity = 0.2
        partyView.layer.shadowRadius = 4
        partyView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    
    }
}
