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
class OverviewViewController: UIViewController {
    
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
    
    /**
     Ausloggen des Benutzers und rückkehr zum Startbildschirm
     JM
    */
    @IBAction func logoutButton(_ sender: Any) {
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "374d7602-d864-f029-bc2e-544308d23924"
        ]
        let myUrl :String = "http://api.dleunig.de/logout?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: myUrl)! as URL,
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
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "logout", sender: self)
                }
            }
        })
        
        dataTask.resume()
    }
    
    /**
    Aktion beim Klick auf den Dashboard Button
    */
    @IBAction func showDashboard(_ sender: Any) {
        closeMenu()
    }
    
    
    /**
    Aktion beim Klick auf den Menubutton
    */
    @IBAction func MenuButton(_ sender: Any) {
        if(menuShowing) {
            closeMenu()
        }else {
            openMenu()
        }
    }
    
    // MARK: - Menu
    
    /**
    Oeffnet das Menue mit einer Animation
    */
    func openMenu() {
        leadingContraint.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    /**
    Schliesst das Menue mit einer Animation
    */
    func closeMenu() {
        leadingContraint.constant = -340
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    /**
    Schatten des Menues
    */
    func setMenuProperties() {
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
    }
    
    // MARK: - Navigation
    
    /**
    Veraendert den Text bei zurueck Button auf "", damit nur der Pfeil angezeigt wird.
    */
    func setCustomBackImage() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /**
    Hintergrundbild der Navigation.
    */
    func setCustomBackground() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navbar_background.png"), for: .default)
    }
    
    /**
    Schatten unter der Navigation durch leeres Bild ersetzten, somit wird kein Schatten angezeigt.
    */
    func setCustomShadow() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
