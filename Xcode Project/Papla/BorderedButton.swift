//
//  UIButtonExtension.swift
//  Papla
//
//  Created by Dario Leunig on 19.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import Foundation
import UIKit

class BorderedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Button hat auf jeder Geraetegroesse genau einen Pixel breite
        layer.borderWidth = 1/UIScreen.main.nativeScale
        layer.borderColor = Colors.purple.cgColor
    }
}
