//
//  NewPartyViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 11.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

class NewPartyViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        startDateTextField.delegate = self
        startTimeTextField.delegate = self
        locationTextField.delegate = self
        endDateTextField.delegate = self
        endTimeTextField.delegate = self
        descriptionTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Sorgt dafür, dass die Tastatur eingefahren wird, wenn irgendwo hingedrückt wird
     */
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        nameTextField.resignFirstResponder()
        startDateTextField.resignFirstResponder()
        startTimeTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
        endTimeTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        self.view.endEditing(true)
    }

    func validateTextField() -> Bool {
        let myColor = UIColor.red
        nameTextField.layer.borderWidth = 0
        startDateTextField.layer.borderWidth = 0
        startTimeTextField.layer.borderWidth = 0
        locationTextField.layer.borderWidth = 0
        endDateTextField.layer.borderWidth = 0
        endTimeTextField.layer.borderWidth = 0
        descriptionTextField.layer.borderWidth = 0
        
        if(nameTextField.text! == "") {
            nameTextField.layer.borderColor = myColor.cgColor
            nameTextField.layer.borderWidth = 1
            return false
        }
        if(startDateTextField.text! == "") {
            startDateTextField.layer.borderColor = myColor.cgColor
            startDateTextField.layer.borderWidth = 1
            return false
        }else {
            let pat = "\\d\\d\\d\\d-\\d\\d-\\d\\d"
            let regex = try! NSRegularExpression(pattern: pat, options: [])
            
            let matches = regex.matches(in: startDateTextField.text!, options: [], range: NSRange(location: 0, length: startDateTextField.text!.characters.count))
            if(matches.count != 1) {
                startDateTextField.layer.borderColor = myColor.cgColor
                startDateTextField.layer.borderWidth = 1
                return false
            }
        }
        if(startTimeTextField.text! == "") {
            startTimeTextField.layer.borderColor = myColor.cgColor
            startTimeTextField.layer.borderWidth = 1
            return false
        }else {
            let pat = "\\d\\d\\:\\d\\d"
            let regex = try! NSRegularExpression(pattern: pat, options: [])
            
            let matches = regex.matches(in: startTimeTextField.text!, options: [], range: NSRange(location: 0, length: startTimeTextField.text!.characters.count))
            if(matches.count != 1) {
                startTimeTextField.layer.borderColor = myColor.cgColor
                startTimeTextField.layer.borderWidth = 1
                return false
            }
        }
        if(locationTextField.text! == "") {
            locationTextField.layer.borderColor = myColor.cgColor
            locationTextField.layer.borderWidth = 1
            return false
        }
        if(endDateTextField.text! == "") {
            endDateTextField.layer.borderColor = myColor.cgColor
            endDateTextField.layer.borderWidth = 1
            return false
        }else {
            let pat = "\\d\\d\\d\\d-\\d\\d-\\d\\d"
            let regex = try! NSRegularExpression(pattern: pat, options: [])
            
            let matches = regex.matches(in: endDateTextField.text!, options: [], range: NSRange(location: 0, length: endDateTextField.text!.characters.count))
            if(matches.count != 1) {
                endDateTextField.layer.borderColor = myColor.cgColor
                endDateTextField.layer.borderWidth = 1
                return false
            }
        }
        if(endTimeTextField.text! == "") {
            endTimeTextField.layer.borderColor = myColor.cgColor
            endTimeTextField.layer.borderWidth = 1
            return false
        }else {
            let pat = "\\d\\d\\:\\d\\d"
            let regex = try! NSRegularExpression(pattern: pat, options: [])
            
            let matches = regex.matches(in: endTimeTextField.text!, options: [], range: NSRange(location: 0, length: endTimeTextField.text!.characters.count))
            if(matches.count != 1) {
                endTimeTextField.layer.borderColor = myColor.cgColor
                endTimeTextField.layer.borderWidth = 1
                return false
            }
        }
        if(descriptionTextField.text! == "") {
            descriptionTextField.layer.borderColor = myColor.cgColor
            descriptionTextField.layer.borderWidth = 1
            return false
        }
        return true
    }
    
    @IBAction func addParty(_ sender: Any) {
        if(validateTextField()) {
            postParty(name: nameTextField.text!, description: descriptionTextField.text!, startDate: startDateTextField.text!
                , startTime: startTimeTextField.text!, endDate: endDateTextField.text!, endTime: endTimeTextField.text!, location: locationTextField.text!)
        }
    }
    
    
    func postParty(name: String, description: String, startDate: String, startTime: String, endDate: String, endTime: String, location: String) {
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "5a73fcac-e24a-af66-bce8-75bdc6517824"
        ]
        let startDateStr: String = startDate + "T" + startTime + ":00.000Z"
        let endDateStr: String = endDate + "T" + endTime + ":00.000Z"
        let parameters = [
            "id": "",
            "name": name,
            "description": description,
            "startDate": startDateStr,
            "endDate": endDateStr,
            "location": location
            ] as [String : Any]
        do {
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
            let urlString: String = "http://api.dleunig.de/party?api=" + myUser.key!
        
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "addedParty", sender: self)
                }
            }
        })
        
        dataTask.resume()
        }catch{return}
    }
    
}
