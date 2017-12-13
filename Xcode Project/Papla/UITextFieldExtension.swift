//
//  UITextFieldExtension.swift
//  Papla
//
//  Created by Dario Leunig on 22.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    /** Style für Textfield bei dem nur ein Bottom Border besteht. (z.B. auf der Anmelde- oder Registrationsseite)
     * Um das zu erreichen, wird der Border auf .none gesetzt, der eigentliche Border ist ein Schatten mit Höhe 1.
     */
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = Colors.lightgrey.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1/UIScreen.main.nativeScale)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setWhite() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
    }
}
