//
//  StartViewController.swift
//  JSONTest
//
//  Created by Dario Leunig on 08.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    struct Person: Codable {
        let username, password: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = imageView.image!
        let data = UIImageJPEGRepresentation(image, 1.0)
        print(data?.base64EncodedString())
    }
    
    
    @IBAction func doLogin(_ sender: Any) {
        if(userTextField.text != "") {
                performSegue(withIdentifier: "segue", sender: self)
        }
    }
}
