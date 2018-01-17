//
//  PartyOwnerViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 17.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

class PartyOwnerViewController: UIViewController {

    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var ownerlabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var party: Party!
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadParty()
        
        if(party != nil) {
            partyNameLabel.text = party.name
            ownerlabel.text = party.ersteller.name
            locationLabel.text = party.location
            timeLabel.text = party.startDate
            if(party.description != nil) {
                descriptionText.text = party.description
            } else {
                descriptionText.text = ""
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    print(downloadedParty.name)
                    self.party = downloadedParty
                    
                } catch {
                    print("something wrong after downloaded")
                }
            })
            dataTask.resume()
            
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
