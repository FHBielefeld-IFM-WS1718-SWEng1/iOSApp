//
//  UIButtonExtension.swift
//  Papla
//
//  Created by Dario Leunig on 22.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setPurpleBorder() {
        // Button hat auf jeder Geraetegroesse genau einen Pixel Breite
        self.layer.borderWidth = 1/UIScreen.main.nativeScale
        self.layer.borderColor = Colors.purple.cgColor
    }
    
    func setWhiteBorder() {
        // Button hat auf jeder Geraetegroesse genau einen Pixel Breite
        self.layer.borderWidth = 1/UIScreen.main.nativeScale
        self.layer.borderColor = UIColor.white.cgColor
    }
}
