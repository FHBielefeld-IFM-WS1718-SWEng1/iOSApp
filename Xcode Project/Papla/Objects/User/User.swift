//
//  User.swift
//  Papla
//
//  Created by Jendrik Müller on 10.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import Foundation

/**
 # User
 Klasse, die einen Nutzer, der von der API zurückgegeben wird modelliert
 */
class User: Codable {
    var id: Int
    var email: String
    var name: String
    var birthdate: String?
    var gender: Int?
    var profilepicture: String?
    var loginAt: String?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    var key: String?
    
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
    
}

class Picture: Codable {
    var data: String
}
