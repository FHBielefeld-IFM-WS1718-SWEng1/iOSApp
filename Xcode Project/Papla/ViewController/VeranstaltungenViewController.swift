//
//  VeranstaltungenViewController.swift
//  Papla
//
//  Created by Dario Leunig on 05.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

class VeranstaltungenViewController: UIViewController {

    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var buttonBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLbl.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."
        
        textLbl.sizeToFit()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
