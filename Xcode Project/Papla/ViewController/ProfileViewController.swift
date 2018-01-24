//
//  ProfileViewController.swift
//  Papla
//
//  Created by Dario Leunig on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var createdAtTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var profilImage: UIImageView!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        birthTextField.delegate = self
        genderTextField.delegate = self
        
        let indexCreated = myUser.createdAt?.index(of: "T")
        
        usernameTextField.text = myUser.name
        emailTextField.text = myUser.email
        createdAtTextField.text = myUser.createdAt?.substring(to: indexCreated!)
        if(myUser.birthdate != nil) {
            birthTextField.text = myUser.birthdate
        }
        
        uploadButton.isHidden = true
        
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
        
        if(myUser.profilePicture != nil) {
            setProfilePicture(pictureId: myUser.profilePicture!)
        }
    }
    
    func setProfilePicture(pictureId: String) {
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "e342f642-1863-4f89-6eb6-933b8609ca24"
        ]
        print(myUser.profilePicture!)
        var urlString: String = "http://api.dleunig.de/image/" + myUser.profilePicture! + "?api=" + myUser.key!
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
                self.profilImage.image = decodedimage
            }
        })
        
        dataTask.resume()
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
        if(birthTextField.text != "") {
            let pat = "\\d\\d\\d\\d-\\d\\d-\\d\\d"
            let regex = try! NSRegularExpression(pattern: pat, options: [])
            
            let matches = regex.matches(in: birthTextField.text!, options: [], range: NSRange(location: 0, length: birthTextField.text!.characters.count))
            if(matches.count == 1) {
                putBirthdate(birthdate: birthTextField.text!)
            }else {
                birthTextField.layer.borderWidth = 1.0
            }
        }
        
    }
    
    func putGender(gender: String) {

        let headers = [
            "content-type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "38503a8b-f705-d9db-d953-794f81fcce15"
        ]
        
        let postDataString = "{\"gender\":" + gender + "}"
        let postData = NSData(data: postDataString.data(using: String.Encoding.utf8)!)
        
        let myurlString = "http://api.dleunig.de/user/" + String(myUser.id) + "?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: myurlString)! as URL,
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
    
    func putBirthdate(birthdate: String) {
        let headers = [
            "content-type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "38503a8b-f705-d9db-d953-794f81fcce15"
        ]
        
        let postDataString = "{\"birthdate\":\"" + birthdate + "T00:00:00.000Z\"}"
        let postData = NSData(data: postDataString.data(using: String.Encoding.utf8)!)
        
        let myurlString = "http://api.dleunig.de/user/" + String(myUser.id) + "?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: myurlString)! as URL,
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
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    

    }
    
    @IBAction func uploadPicture(_ sender: Any) {
        let data = UIImageJPEGRepresentation(profilImage.image!, 1.0)
        let strBase64: String = (data?.base64EncodedString())!
        
        putProfilePicture(profilepicture: strBase64)
        uploadButton.isHidden = true
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profilImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        picker.dismiss(animated: true, completion:nil)
        uploadButton.isHidden = false

    }
    
    func putProfilePicture(profilepicture: String) {
        let headers = [
            "content-type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "38503a8b-f705-d9db-d953-794f81fcce15"
        ]
    
        let postDataString = "{\"data\":\"" + profilepicture + "\"}"
        let postData = NSData(data: postDataString.data(using: String.Encoding.utf8)!)
    
        let myurlString = "http://api.dleunig.de/image" + "?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: myurlString)! as URL,
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
    }
    
}


