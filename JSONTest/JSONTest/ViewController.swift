//
//  ViewController.swift
//  JSONTest
//
//  Created by Dario Leunig on 01.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

struct Party {
    let name: String
    let values: Array<String>
    
    init(json: [String: Any]) {
        name = json["name"] as? String ?? ""
        values = json["values"] as? Array<String> ?? Array<String>()
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "http://api.dleunig.de/parties"
        guard let url = URL(string: jsonUrlString) else
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //pass
            guard let data = data else {return}
            
            /*
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString)
            */
 
            do {
                guard let json = try
                    JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                        return}
                
                let party = Party(json: json)
                
                print(party.name)
                
            } catch let jsonERR {
                print("Error serializing json: ", jsonERR)
            }
            
        }.resume()
        
        /*
        let myParty = Party(name: "Darios Party")
        print(myParty)
        */
    }


}

