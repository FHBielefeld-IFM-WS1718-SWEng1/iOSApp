//
//  MenuView.swift
//  Papla
//
//  Created by Dario Leunig on 19.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import Foundation
import UIKit

class MenuView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Erstellt ein CAGradientLayer() Objekt
        let gradientLayer = CAGradientLayer()
        // bounds = gleiche Groesse wie das Objekt (Button, View ect.)
        gradientLayer.frame = bounds
        gradientLayer.colors = [Colors.blue.cgColor, Colors.purple.cgColor]
        // Bereich in dem die Farben sich "vermischen", sodass auf der ganzen Flaeche ein Verlauf entsteht
        gradientLayer.locations = [0.0, 1.0]
        // Startbereich des Verlaufes
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        // Endbereich des Verlaufes
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        // Setzt den erzeugten Layer auf Index 0, damit er ganz oben liegt
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
