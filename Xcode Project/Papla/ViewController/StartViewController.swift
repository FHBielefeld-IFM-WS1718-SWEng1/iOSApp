//
//  StartViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

var name = ""

class StartViewController: UIViewController, UITextFieldDelegate {
    
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
    
    
    var registryFormShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if(emailTextField.text == "Dario" && passwordTextfield.text == "test"){
            name = emailTextField.text!
            performSegue(withIdentifier: "signIn", sender: self)
        }else {
            passwordTextfield.text = ""
        }
    }
    
    @IBAction func pressRegisterFinishButton(_ sender: Any) {
        if(emailTextFieldRegistryView.text != "" && usernameTextFieldRegistryView.text != "" && passwordTextFieldRegistryView.text != "" && repeatPasswordTextFieldRegistryView.text == passwordTextFieldRegistryView.text) {
            name = usernameTextFieldRegistryView.text!
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
        leadingConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        registryFormShowing = !registryFormShowing
    }
    
    func closeRegistryForm() {
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
