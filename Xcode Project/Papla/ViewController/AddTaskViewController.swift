//
//  AddTaskViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 20.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    
    var party: Party!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTextField.delegate = self
        confirmLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Sorgt dafür, dass die Tastatur eingefahren wird, wenn irgendwo hingedrückt wird
     */
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        taskTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    @IBAction func addTaskEvent(_ sender: Any) {
        if(taskTextField.text != "") {
            postTask()
            taskTextField.text = ""
            confirmLabel.isHidden = false
        }
    }
    
    func postTask() {
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "776a0ec9-3f10-1bdb-fa47-126944c3e1b1"
        ]
        let parameters = [
            "user_id": myUser.id,
            "party_id": party.id,
            "text": taskTextField.text!,
            "status": 0
            ] as [String : Any]
        
        do {
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let urlString: String = "http://api.dleunig.de/party/task?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL,
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
            }
        })
        
        dataTask.resume()
        }catch{return}
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
