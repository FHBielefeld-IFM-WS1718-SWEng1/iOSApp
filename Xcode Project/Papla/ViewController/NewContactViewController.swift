//
//  NewContactViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 14.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

var myUserList: UserList?

class NewContactViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "85d302b5-8159-3e00-5fef-82bd6520fdd5"
        ]
        let urlString = "http://api.dleunig.de/user?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                print("something is wrong")
                return
            }
            
            print("downloaded")
            
            
            do {
                let decoder = JSONDecoder()
                myUserList = try decoder.decode(UserList.self, from: data)
                
            }catch {
                print("JSON Error")
                return
            }
        })
        
        dataTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addContact(_ sender: Any) {
        if(myUserList != nil) {
            for user in myUserList!.values {
                if(user.email == emailTextField.text!) {
                    let headers = [
                        "Content-Type": "application/json",
                        "Cache-Control": "no-cache",
                        "Postman-Token": "88d83c3d-15fa-a60b-0ad8-f9cfad59472d"
                    ]
                    let parameters = ["userid": user.id] as [String : Any]
                    do{
                    let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    let urlString = "http://api.dleunig.de/user/contact?api=" + myUser.key!
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
                                self.performSegue(withIdentifier: "addedContact", sender: self)
                            }
                        }
                    })
                    
                    dataTask.resume()
                    return
                    }catch{return}
                }
            }
            errorLabel.isHidden = false
            errorLabel.text = "User nicht gefunden"
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Fehler bei der Verbindung mit dem Server"
        }
    }
    

}
