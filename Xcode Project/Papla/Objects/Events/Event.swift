//
//  Event.swift
//  Papla
//
//  Created by Dario Leunig on 08.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit
/**
 # Events
 stellt das Array von Party, dass von der API zurückgegeben wird dar
 */
class Events: Codable {
    let count: Int
    let parties: [Event]
    
    init(count: Int, parties: [Event]) {
        self.count = count
        self.parties = parties
    }
}
/**
 # Event
 stellt eine einzelne Party in der Liste dar
 */
class Event: Codable {
    let id: Int
    let name: String?
    let description: String?
    let startDate: String?
    let endDate: String?
    let location: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    let user_id: Int?
    
    
    init(id: Int, name: String, description: String, startDate: String, endDate: String, location: String, createdAt: String, updatedAt: String, deletedAt: String, user_id: Int) {
        self.id = id
        self.name = name
        self.description = name
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.user_id = user_id
    }
}
