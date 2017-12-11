//
//  User.swift
//  Papla
//
//  Created by Jendrik Müller on 10.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import Foundation


struct User: Decodable {
    let id: Int
    let email: String
    let name: String
    let birthdate: String
    let gender: Int
    let profilepicture: String
    let loginAt: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String
    let key: String
    /*
    init(id: Int, email: String, name: String, birthdate: String, gender: Int,profilepicture: String, loginAt: String, createdAt: String, updatedAt:String, deletedAt: String, key: String) {
        
        self.id = id
        self.email = email
        self.name = name
        self.birthdate = birthdate
        self.gender = gender
        self.profilepicture = profilepicture
        self.loginAt = loginAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.key = key
    }
    */
}
