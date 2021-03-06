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
    
    @IBOutlet weak var profilePicture: UIImageView!
    
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
        
        if(contact.profilepicture != nil) {
            setProfilePicture(pictureId: contact.profilepicture!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setProfilePicture(pictureId: String) {
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "e342f642-1863-4f89-6eb6-933b8609ca24"
        ]
        
        var urlString: String = "http://api.dleunig.de/image/" + pictureId + "?api=" + myUser.key!
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
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
            print("downloaded")
            var picture: String = ""
            do {
                let decoder = JSONDecoder()
                let downloadedPicture = try decoder.decode(Picture.self, from: data)
                picture = downloadedPicture.data
                
            }catch {
                print("JSON Error")
                return
            }
            
            DispatchQueue.main.async {
                let dataDecoded : Data = Data(base64Encoded: picture, options: .ignoreUnknownCharacters)!
                let decodedimage = UIImage(data: dataDecoded)
                self.profilePicture.image = decodedimage
            }
        })
        
        dataTask.resume()
    }
    
    @IBAction func deleteKontakt(_ sender: Any) {
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "184c6030-5323-d9d1-39af-da3a26a1c841"
        ]
        let parameters = ["userid": 42] as [String : Any]
        do{
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let urlString: String = "http://api.dleunig.de/user/contact?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "DELETE"
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
