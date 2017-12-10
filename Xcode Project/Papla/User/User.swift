//
//  User.swift
//  Papla
//
//  Created by Jendrik Müller on 10.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import Foundation

class User: Codable {
    let id: Int
    let name: String
    let email: String
    let birthday: String
    let gender: Int
    let loginAt: String
    
    init(id: Int, name: String, email: String, birthday: String, gender: Int, loginAt: String) {
        
        self.id = id
        self.name = name
        self.email = email
        self.birthday = birthday
        self.gender = gender
        self.loginAt = loginAt
    }
    
}
