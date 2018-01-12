//
//  ConfirmModalViewController.swift
//  Papla
//
//  Created by Alexander Bergmann on 12.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

class ConfirmModalViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var outsideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmTouchUpInside(_ sender: UIButton) {
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "2a123482-a1c9-6001-ff18-e4f7337ad500"
        ]
        
        let myurlString = "http://api.dleunig.de/user/" + String(myUser.id) + "?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: myurlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                self.dismiss(animated: true, completion: nil)
            }
        })
        dismiss(animated: true, completion: nil)
        dataTask.resume()
    }
    
    @IBAction func cancelTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func outsideTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
