//
//  StartViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit


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
        signInButton.setGradientBackground(colorOne: Colors.blue, colorTwo: Colors.purple)
        
        // Aussehen vom registerFinishButton
        registerFinishButton.setWhiteBorder()
        
        // Aussehen vom registerButton
        registerButton.setPurpleBorder()
        
        setRegistryFormProperties()
    }
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        
        emailTextFieldRegistryView.resignFirstResponder()
        usernameTextFieldRegistryView.resignFirstResponder()
        passwordTextFieldRegistryView.resignFirstResponder()
        repeatPasswordTextFieldRegistryView.resignFirstResponder()
        self.view.endEditing(true)
    }

    
    @IBAction func pressSignInButton(_ sender: Any) {
        if(emailTextField.text != "" && passwordTextfield.text != ""){
            doLogin(eMail: emailTextField.text!, password: passwordTextfield.text!)
        }else {
            passwordTextfield.text = ""
        }
    }
    
    func doLogin(eMail: String, password: String) {
        let url = URL(string: "http://www.kaleidosblog.com/tutorial/login/api/login")
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let paramToSend = "username=" + eMail + "&password=" + password
        
        request.httpBody = paramToSend.data(using: String.Encoding.utf8)
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            guard let _:Data = data else { return }
            
            let json:Any?
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
                return
            }
            
            
            guard let server_response = json as? NSDictionary else {
                return
            }
            
            if let data_block = server_response["data"] as? NSDictionary
            {
                if let session_data = data_block["session"] as? String
                {
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.performSegue(withIdentifier: "segue", sender: self)
                    })
                }
            }
        })
        task.resume()
    }
    
    @IBAction func pressRegisterFinishButton(_ sender: Any) {
        if(emailTextFieldRegistryView.text != "" && usernameTextFieldRegistryView.text != "" && passwordTextFieldRegistryView.text != "" && repeatPasswordTextFieldRegistryView.text == passwordTextFieldRegistryView.text) {
            performSegue(withIdentifier: "signIn", sender: self)
        }
    }
    
    @IBAction func pressRegisterButton(_ sender: Any) {
        openMenuRegistryForm()
    }
    
    @IBAction func pressArrowDownButton(_ sender: Any) {
        closeRegistryForm()
    }
    
    
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
    
    // Schatten der RegistrierenView
    func setRegistryFormProperties() {
        registryView.layer.shadowOpacity = 0.2
        registryView.layer.shadowRadius = 8
    }
    
}
