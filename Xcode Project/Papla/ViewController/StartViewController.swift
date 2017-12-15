//
//  StartViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit
///Representiert einen User, der von der API zurück gegeben wird
var myUser = User(id: 0, email: "", name: "", birthdate: "", gender: 0, profilepicture: "", loginAt: "", createdAt: "", updatedAt: "", deletedAt: "", key: "")


class StartViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    
    @IBOutlet weak var registryView: MenuView!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerFinishButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emailTextFieldRegistryView: UITextField!
    @IBOutlet weak var usernameTextFieldRegistryView: UITextField!
    @IBOutlet weak var passwordTextFieldRegistryView: UITextField!
    @IBOutlet weak var repeatPasswordTextFieldRegistryView: UITextField!
    
    var effect:UIVisualEffect!
    
    var registryFormShowing = false
    
    /**
     - Wird nach dem Laden des Views ausgeführt
     - setzt den Delegenten für die Textfelder
     - setzt den Rand der Textfelder
     - setzt die Effekte
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
        emailTextField.delegate = self
        passwordTextfield.delegate = self
        
        emailTextFieldRegistryView.delegate = self
        usernameTextFieldRegistryView.delegate = self
        passwordTextFieldRegistryView.delegate = self
        repeatPasswordTextFieldRegistryView.delegate = self
        
        emailTextField.setBottomBorder()
        passwordTextfield.setBottomBorder()
        
        emailTextFieldRegistryView.setWhite()
        usernameTextFieldRegistryView.setWhite()
        passwordTextFieldRegistryView.setWhite()
        repeatPasswordTextFieldRegistryView.setWhite()
        
        /*
        * Verhindert, NavigationBar nachdem man sich ausgeloggt hat und wieder zur
        * StartView zurueck kommt.
        */
        self.navigationController?.isNavigationBarHidden = true

        // Aussehen vom signInButton
        //signInButton.setGradientBackgroundDiagonal(colorOne: Colors.blue, colorTwo: Colors.purple)
        
        // Aussehen vom registerFinishButton
        registerFinishButton.setWhiteBorder()
        
        // Aussehen vom registerButton
        registerButton.setPurpleBorder()
        
        setRegistryFormProperties()
    }
    
    /**
     Sorgt dafür, dass die Tastatur eingefahren wird, wenn irgendwo hingedrückt wird
    */
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        
        emailTextFieldRegistryView.resignFirstResponder()
        usernameTextFieldRegistryView.resignFirstResponder()
        passwordTextFieldRegistryView.resignFirstResponder()
        repeatPasswordTextFieldRegistryView.resignFirstResponder()
        self.view.endEditing(true)
    }

    /**
     Wird ausgeführt, wenn der Anmelden Button betätigt wird
     - Überprüft ob Textfelder ausgefüllt wurden
     - Ruft bei ausgefüllten Textfelder die Methode doLogin auf
   */
    @IBAction func pressSignInButton(_ sender: Any) {
        if(emailTextField.text != "" && passwordTextfield.text != ""){
            doLogin(eMail: emailTextField.text!, password: passwordTextfield.text!)
        }
        
    }
    
    /**     Schickt einen Post Request an die API und wertet das Zurückgegebene JSON aus
     
     Todo:
     - suchen nach einer möglichkeit JSON nach Swift 4 standart zu parsen trotz null Werten
     
     
     - Parameter eMail: eMail, die der Nutzer eingegeben hat
     - Parameter password: password, das der Nutzer eingegeben hat
    */
    func doLogin(eMail: String, password: String) {
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "9a2273e0-e96a-f83c-2f46-3539007e2025"
        ]
        let parameters = [
            "password": password,
            "email": eMail
            ] as [String : Any]
        do {
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://api.dleunig.de/login")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                print("something is wrong")
                return
            }
            
            print("downloaded")
            
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    // Access value of username, name, and email by its key
                    let idValue = parseJSON["id"] as? Int
                    let emailValue = parseJSON["email"] as? String
                    let nameValue = parseJSON["name"] as? String
                    let birthdateValue = parseJSON["birthdate"] as? String
                    let genderValue = parseJSON["gender"] as? Int
                    let profilepictureValue = parseJSON["profilepicture"] as? String
                    let loginAtValue = parseJSON["loginAt"] as? String
                    let createdAtValue = parseJSON["createdAt"] as? String
                    let updatedAtValue = parseJSON["updatedAt"] as? String
                    let deletedAtValue = parseJSON["deletedAt"] as? String
                    let keyValue = parseJSON["key"] as? String
                    
                    if(idValue == nil){
                        return
                    }
                    
                    myUser.id = idValue!
                    myUser.email = emailValue!
                    myUser.name = nameValue!
                    myUser.createdAt = createdAtValue!
                    myUser.updatedAt = updatedAtValue!
                    myUser.key = keyValue!
                    
                    if(birthdateValue != nil) {
                        myUser.birthdate = birthdateValue!
                    }
                    if(genderValue != nil) {
                        myUser.gender = genderValue!
                    }
                    if(profilepictureValue != nil) {
                        myUser.profilepicture = profilepictureValue!
                    }
                    if(loginAtValue != nil) {
                        myUser.loginAt = loginAtValue!
                    }
                    if(deletedAtValue != nil) {
                        myUser.deletedAt = deletedAtValue!
                    }
                }
                
            }catch {
                print("JSON Error")
                return
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "signIn", sender: self)
            }
            
            
        })
        dataTask.resume()
        } catch {return}
    }
    
    /**
     Wird aufgerufen, wenn der Button zum Abschließen einer  Regestriereung betätigt wird
     Wertet die Textfelder aus und führt gegebenenfalls einen viewwechsel durch
     Todo:
     - Senden eines Requests an die API
    */
    @IBAction func pressRegisterFinishButton(_ sender: Any) {
        if(emailTextFieldRegistryView.text != "" && usernameTextFieldRegistryView.text != "" && passwordTextFieldRegistryView.text != "" && repeatPasswordTextFieldRegistryView.text == passwordTextFieldRegistryView.text) {
            performSegue(withIdentifier: "signIn", sender: self)
        }
    }
    
    /**
     Wird ausgeführt, wenn der Button zum öffnen des Registrieren Menüs geöffnet wird
    */
    @IBAction func pressRegisterButton(_ sender: Any) {
        openMenuRegistryForm()
    }
    
    /**
     Wird ausgeführt, wenn der Button zum schließen des Registrieren Menüs geöffnet wird
     */
    @IBAction func pressArrowDownButton(_ sender: Any) {
        closeRegistryForm()
    }
    
    /**
     öffnet den view zum Registrieren
    */
    func openMenuRegistryForm() {
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
        }
        
        leadingConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        registryFormShowing = !registryFormShowing
    }
    
    /**
     schließt den view zum Registrieren
     */
    func closeRegistryForm() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.effect = nil
            
        })
        
        leadingConstraint.constant = 400
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        registryFormShowing = !registryFormShowing
    }
    
    /// Schatten der RegistrierenView
    func setRegistryFormProperties() {
        registryView.layer.shadowOpacity = 0.2
        registryView.layer.shadowRadius = 8
    }
    
}
