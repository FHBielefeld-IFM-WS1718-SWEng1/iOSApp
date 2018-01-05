//
//  ProfileViewController.swift
//  Papla
//
//  Created by Dario Leunig on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var createdAtTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        birthTextField.delegate = self
        genderTextField.delegate = self
        
        let indexCreated = myUser.createdAt?.index(of: "T")
        
        usernameTextField.text = myUser.name
        emailTextField.text = myUser.email
        createdAtTextField.text = myUser.createdAt?.substring(to: indexCreated!)
        
        if(myUser.birthdate != nil) {
            let index = myUser.birthdate?.index(of: "T")
            birthTextField.text = myUser.birthdate?.substring(to: index!)
        }
        if(myUser.gender != nil) {
            print("hier")
            print(myUser.gender!)
            switch myUser.gender! {
            case 1:
                genderTextField.text = "m"
            case 2:
                genderTextField.text = "w"
            case 3:
                genderTextField.text = "n"
            default:
                break
            }
        }
    }
    
    /**
     Sorgt dafür, dass die Tastatur eingefahren wird, wenn irgendwo hingedrückt wird
     */
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        birthTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    @IBAction func safeProfile(_ sender: Any) {
        let myColor = UIColor.red
        genderTextField.layer.borderWidth = 0
        birthTextField.layer.borderWidth = 0
        if(genderTextField.text != "") {
            switch genderTextField.text! {
            case "m":
                if(myUser.gender == nil || myUser.gender != 1) {
                    putGender(gender: "1")
                    myUser.gender = 1
                }
            case "w":
                if(myUser.gender == nil || myUser.gender != 2) {
                    putGender(gender: "2")
                    myUser.gender = 2
                }
            case "n":
                if(myUser.gender == nil || myUser.gender != 3) {
                    putGender(gender: "3")
                    myUser.gender = 3
                }
            default:
                genderTextField.layer.borderColor = myColor.cgColor
                genderTextField.layer.borderWidth = 1.0
                break
            }
        }
        
        
    }
    
    func putGender(gender: String) {

        let headers = [
            "content-type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "5a39887e-acec-2212-2e83-2ed127ebf9f6"
        ]
        
        let myBodyString :String = "{\"gender\":" + gender + "}"
        let postData = NSData(data: myBodyString.data(using: String.Encoding.utf8)!)
        
        let myUrlString = "http://api.dleunig.de/user/" + String(myUser.id) + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: myUrlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
    }
}
