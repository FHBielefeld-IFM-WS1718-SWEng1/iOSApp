//
//  StartViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit
import QuartzCore


///Representiert einen User, der von der API zurück gegeben wird
var myUser = User(id: 0, email: "", name: "", birthdate: "", gender: 0, profilePicture: "", loginAt: "", createdAt: "", updatedAt: "", deletedAt: "", key: "")


class StartViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    
    @IBOutlet weak var registryView: MenuViewController!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerFinishButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
        
        // Login
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        
        // Register
        emailTextFieldRegistryView.delegate = self
        usernameTextFieldRegistryView.delegate = self
        passwordTextFieldRegistryView.delegate = self
        repeatPasswordTextFieldRegistryView.delegate = self
        
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
        passwordTextField.resignFirstResponder()
        
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
        if(loginTextfieldsValidate()){
            doLogin(eMail: emailTextField.text!, password: passwordTextField.text!)
        }
        
    }
    
    /**
     Überprüft ob die Textfelder tum Registrieren Korrekt ausgefüllt wurden.
     Bei ungültigen eingaben wird der Rand des erstel ungültigen Textfeldes Rot umrandet
     - Returns: gibt true zurück, wenn alle Eingaben gültig sind, sonst false.
     */
    func loginTextfieldsValidate() -> Bool {
        let myColor = UIColor.red
        emailTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
        if(emailTextField.text != "") {
            let pat = "\\w*\\.?w*@([a-z]+)-?([a-z]+)\\.([a-z]+)"
            let regex = try! NSRegularExpression(pattern: pat, options: [])
            
            let matches = regex.matches(in: emailTextField.text!, options: [], range: NSRange(location: 0, length: emailTextField.text!.characters.count))
            if(matches.count != 1) {
                emailTextField.layer.borderColor = myColor.cgColor
                emailTextField.layer.borderWidth = 1.0
                return false
            }
            
        }else {
            emailTextField.layer.borderColor = myColor.cgColor
            emailTextField.layer.borderWidth = 1.0
            return false;
        }
        if(passwordTextField.text == "") {
            passwordTextField.layer.borderColor = myColor.cgColor
            passwordTextField.layer.borderWidth = 1.0
            return false
        }
        
        return true
    }
    
    /**     Schickt einen Post Request an die API und wertet das Zurückgegebene JSON aus
     
     
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
            
            
            do {
                let decoder = JSONDecoder()
                let downloadedUser = try decoder.decode(User.self, from: data)
                myUser = downloadedUser
                
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
    */
    @IBAction func pressRegisterFinishButton(_ sender: Any) {
        if(registerTextfieldsValidate()) {
            doRegister(username: usernameTextFieldRegistryView.text!, eMail: emailTextFieldRegistryView.text!, password: passwordTextFieldRegistryView.text!)
            sleep(1)
            doLogin(eMail: emailTextFieldRegistryView.text!, password: passwordTextFieldRegistryView.text!)
        }
    }
    
    /**
     Überprüft ob die Textfelder tum Registrieren Korrekt ausgefüllt wurden.
     Bei ungültigen eingaben wird der Rand des erstel ungültigen Textfeldes Rot umrandet
     - Returns: gibt true zurück, wenn alle Eingaben gültig sind, sonst false.
    */
    func registerTextfieldsValidate() -> Bool {
        let myColor = UIColor.red
        emailTextFieldRegistryView.layer.borderWidth = 0
        usernameTextFieldRegistryView.layer.borderWidth = 0
        passwordTextFieldRegistryView.layer.borderWidth = 0
        repeatPasswordTextFieldRegistryView.layer.borderWidth = 0
        if(emailTextFieldRegistryView.text != "") {
            let pat = "\\w*\\.?w*@([a-z]+)-?([a-z]+)\\.([a-z]+)"
            let regex = try! NSRegularExpression(pattern: pat, options: [])
            
            let matches = regex.matches(in: emailTextFieldRegistryView.text!, options: [], range: NSRange(location: 0, length: emailTextFieldRegistryView.text!.characters.count))
            if(matches.count != 1) {
                emailTextFieldRegistryView.layer.borderColor = myColor.cgColor
                emailTextFieldRegistryView.layer.borderWidth = 1.0
                return false
            }
            
        }else {
                emailTextFieldRegistryView.layer.borderColor = myColor.cgColor
                emailTextFieldRegistryView.layer.borderWidth = 1.0
                return false;
        }
        if(usernameTextFieldRegistryView.text == "") {
            usernameTextFieldRegistryView.layer.borderColor = myColor.cgColor
            usernameTextFieldRegistryView.layer.borderWidth = 1.0
            return false
        }
        if(passwordTextFieldRegistryView.text == "") {
            passwordTextFieldRegistryView.layer.borderColor = myColor.cgColor
            passwordTextFieldRegistryView.layer.borderWidth = 1.0
            return false
        }
        
        if(repeatPasswordTextFieldRegistryView.text != passwordTextFieldRegistryView.text) {
            repeatPasswordTextFieldRegistryView.layer.borderColor = myColor.cgColor
            repeatPasswordTextFieldRegistryView.layer.borderWidth = 1.0
            return false
        }
        
        return true
    }
    
    /**
     Sendet einen POST-Request an die API, mit den übergeben Werten, zum Registrieren eines Nutzers
     
     - Parameter username: Nutzername des zu Registrierenden Nutzers
     - Parameter eMail: e-Mail des neuen Nutzers
     - Parameter password: Passwort des neuen Nutzers
    */
    func doRegister(username: String, eMail: String, password: String) {
        let headers = [
            "content-type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "ec9f0cd5-2ca9-f0da-f9cd-f5f5d782fdc8"
        ]
        
        let parameters = [
            "password": password,
            "name": username,
            "email": eMail
            ] as [String : Any]
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
    
    let request = NSMutableURLRequest(url: NSURL(string: "http://api.dleunig.de/register")! as URL,
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
        
        
        do {
            let decoder = JSONDecoder()
            let downloadedUser = try decoder.decode(RegisterUser.self, from: data)
            print(downloadedUser.email)
            
        }catch {
            print("JSON Error")
            return
        }
    })
    dataTask.resume()
    }
    catch{return}
    closeRegistryForm()
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
