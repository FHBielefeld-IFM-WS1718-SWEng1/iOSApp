//
//  ViewController.swift
//  Papla
//
//  Created by Dario Leunig on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

/**
 View, der das Dashboard beinhaltet
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMenuProperties()
        
        //setCustomBackground()
        setCustomShadow()
        setCustomBackImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userNameLabel.text = myUser.name
    }
    
    // Aktion beim Klick auf den Dashboard Button
    @IBAction func showDashboard(_ sender: Any) {
        closeMenu()
    }
    
    
    // Aktion beim Klick auf den Menubutton
    @IBAction func MenuButton(_ sender: Any) {
        if(menuShowing) {
            closeMenu()
        }else {
            openMenu()
        }
    }
    
    // MARK: - Menu
    
    // Oeffnet das Menue mit einer Animation
    func openMenu() {
        leadingContraint.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    // Schliesst das Menue mit einer Animation
    func closeMenu() {
        leadingContraint.constant = -340
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    // Schatten des Menues
    func setMenuProperties() {
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
    }
    
    // MARK: - Navigation
    
    // Veraendert den Text bei zurueck Button auf "", damit nur der Pfeil angezeigt wird.
    func setCustomBackImage() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setCustomBackground() {
        // Hintergrundbild der Navigation.
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navbar_background.png"), for: .default)
    }
    
    
    func setCustomShadow() {
        // Schatten unter der Navigation durch leeres Bild ersetzten, somit wird kein Schatten angezeigt.
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
