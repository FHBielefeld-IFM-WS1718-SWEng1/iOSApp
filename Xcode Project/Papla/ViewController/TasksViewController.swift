//
//  TasksViewController.swift
//  Papla
//
//  Created by Dario Leunig on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    @IBOutlet var passwordForgottenView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @et weak var passwordForgottenButton: UIButton!
    
    var effect:UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
        passwordForgottenView.layer.cornerRadius = 5
    }
    
    func animateIn() {
        self.view.addSubview(passwordForgottenView)
        passwordForgottenView.center = self.view.center
        
        passwordForgottenView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        passwordForgottenView.alpha = 0
        
        
        passwordForgottenButton.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.passwordForgottenView.alpha = 1
            self.passwordForgottenView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.passwordForgottenView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.passwordForgottenView.alpha = 0
            
            self.visualEffectView.effect = nil
         
            self.passwordForgottenButton.alpha = 1
            
        }) {(success:Bool) in
            self.passwordForgottenView.removeFromSuperview()
        }
    }

    @IBAction func resetPassword(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        animateOut()
    }
    
}
