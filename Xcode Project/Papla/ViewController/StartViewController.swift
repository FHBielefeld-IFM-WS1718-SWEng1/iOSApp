//
//  StartViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

var name: String = ""

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
        let json = ["password":password, "email":eMail]
        var request = URLRequest(url: URL(string: "http//api.dleunig.de/")!)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }catch {return}
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            guard let data = data, error == nil, response != nil else {
                print("something is wrong")
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let downloadedUser = try decoder.decode(User.self, from: data)
                name = downloadedUser.name
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "signIn", sender: self)
                }
            } catch {
                print("something wrong after downloaded")
            }
        }
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
