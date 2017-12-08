//
//  Party.swift
//  JSONTest
//
//  Created by Dario Leunig on 08.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class Parties: Codable {
    let name: String
    let values: [Party]
    
    init(name: String, values: [Party]) {
        self.name = name
        self.values = values
    }
}

class Party: Codable {
    let id: Int
    let name: String
    let description: String
    
    init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
