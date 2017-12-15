//
//  Contact.swift
//  Papla
//
//  Created by Dario Leunig on 15.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

class Contacts: Codable {
    let count: Int
    let contacts: [Contact]
    
    init(count: Int, contacts: [Contact]) {
        self.count = count
        self.contacts = contacts
    }
}

class Contact: Codable {
    let id: Int
    let email: String?
    let name: String?
    let birthday: String?
    let profilepicture: String?
    let loginAt: String?

    init(id: Int, email: String, name: String, birthday: String, profilepicture: String, loginAt:String) {
        self.id = id
        self.email = email
        self.name = name
        self.birthday = birthday
        self.profilepicture = profilepicture
        self.loginAt = loginAt
    }
}

