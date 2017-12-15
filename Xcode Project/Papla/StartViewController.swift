//
//  StartViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        * Verhindert, NavigationBar nachdem man sich ausgeloggt hat und wieder zur
        * StartView zurueck kommt.
        */
        self.navigationController?.isNavigationBarHidden = true;

        signInButton.setGradientBackground(colorOne: Colors.blue, colorTwo: Colors.purple)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
