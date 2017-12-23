//
//  RegisterUser.swift
//  Papla
//
//  Created by Jendrik Müller on 15.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import Foundation

class RegisterUser: Codable {
    var id: Int
    var name: String
    var email: String
    var updatedAt: String?
    var createdAt: String?
}
