//
//  UserList.swift
//  Papla
//
//  Created by Jendrik Müller on 14.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import Foundation

/**
 Liste aller User
 */
class UserList: Codable {
    let values: [UserInList]
    
    
}
/**
  User aus der Liste aller User
 */
class UserInList: Codable {
    let name: String
    let email: String
    let id: Int
}
