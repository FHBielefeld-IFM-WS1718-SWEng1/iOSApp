//
//  Party.swift
//  Papla
//
//  Created by Jendrik Müller on 17.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import Foundation

class Party: Codable {
    
    let id: Int
    let name: String
    let description: String?
    let startDate: String
    let endDate: String?
    let location: String
    let ersteller: Gast
    let gäste: [Gast]?
}

class Gast: Codable {
    let id: Int
    let name: String
    let email: String
    let birthdate: String
    let gender: Int
    let loginAt: String
}
