//
//  ShowContactsViewController.swift
//  Papla
//
//  Created by Dario Leunig on 12.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

class ShowContactsViewController: UIViewController {
    var contact: Contact!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = contact.name
        emailLabel.text = contact.email
        if(contact.birthdate != nil) {
            birthLabel.text = contact.birthdate!
        }else {
            birthLabel.text = ""
        }
        switch contact.gender {
        case 0:
            genderLabel.text = ""
        case 1:
            genderLabel.text = "männlich"
        case 2:
            genderLabel.text = "weiblich"
        case 3:
            genderLabel.text = "neutral"
        default:
            break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
