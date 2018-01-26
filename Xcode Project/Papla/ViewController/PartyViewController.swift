//
//  PartyViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 20.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

class PartyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var ownerlabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var guestList: UITextView!
    @IBOutlet weak var taskList: UITextView!
    
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var party: Party!
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingTextField.delegate = self
        
        downloadParty()
    }
    
    /**
     Sorgt dafür, dass die Tastatur eingefahren wird, wenn irgendwo hingedrückt wird
     */
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        ratingTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        downloadParty()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setText() {
        partyNameLabel.text = party.name
        ownerlabel.text = party.ersteller.name
        locationLabel.text = party.location
        timeLabel.text = party.startDate
        if(party.description != nil) {
            descriptionText.text = party.description
        } else {
            descriptionText.text = ""
        }
        guestList.text = ""
        var guestListString: String = ""
        for user in party.guests! {
            guestListString += user.User.name!
            guestListString += "\n"
        }
        guestList.text = guestListString
        
        taskList.text = ""
        var taskListString: String = ""
        for task in party.tasks {
            taskListString += task.text! + "  "
            if(task.User != nil) {
                taskListString += task.User!.name!
            }
            taskListString += "\n"
        }
        taskList.text = taskListString
        
        if(party.ratingAverage != nil) {
            ratingLabel.text = String(describing: party.ratingAverage!) + "/10"
        }
    }
    
    func downloadParty() {
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "8fb51f41-0b5e-fc77-4fa4-136c45e5d449"
        ]
        let urlString = "http://api.dleunig.de/party/" + String(event.id) + "?api=" + myUser.key!
        print(urlString)
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        print("vor datatask")
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
            
            guard let data = data, error == nil else {
                print("something is wrong")
                return
            }
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                let downloadedParty = try decoder.decode(Party.self, from: data)
                self.party = downloadedParty
                DispatchQueue.main.async {
                    self.setText()
                }
                
            } catch {
                print("something wrong after downloaded")
            }
        })
        dataTask.resume()
        
    }
    
    
    func tableView(_ guestTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(party == nil) {
            return 0
        }
        return party.guests!.count
    }
    
    /**
     Fuellt die TableView Zellen mit Inhalt
     */
    func tableView(_ guestTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Hier")
        guard let cell = guestTable.dequeueReusableCell(withIdentifier: "GuestCell") as? GuestCell else {return UITableViewCell()}
        print("fb")
        print(party.guests![indexPath.row].User.name)
        cell.nameLabel.text = party.guests![indexPath.row].User.name
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "addGuest":
            guard let AddGuestViewController = segue.destination as? AddGuestViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            
            AddGuestViewController.party = party
            
        case "addTask":
            guard let AddTaskViewController = segue.destination as? AddTaskViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            AddTaskViewController.party = party
        default:
            break
        }
    }
    @IBAction func addRating(_ sender: Any) {
        if(ratingTextField.text != "") {
            let headers = [
                "Content-Type": "application/json",
                "Cache-Control": "no-cache",
                "Postman-Token": "77881d1a-9d3e-bbcf-8305-1785d3543b79"
            ]
            let parameters = [
                "partyid": party.id,
                "rating": Int(ratingTextField.text!)!
                ] as [String : Any]
            
            do {
                let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                
                let urlString: String = "http://api.dleunig.de/party/rating?api=" + myUser.key!
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
                    }
                })
                
                dataTask.resume()
            }catch{return}
            
            downloadParty()
        }
    }
    

}
