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
    let name: String
    let values: [Event]
    
    init(name: String, values: [Event]) {
        self.name = name
        self.values = values
    }
}
/**
 # Event
 stellt eine einzelne Party in der Liste dar
 */
class Event: Codable {
    let id: Int
    let name: String
    let who: String
    let date: String
    let description: String
    let img: String
    
    init(id: Int, name: String, who: String, date: String, description: String, img: String) {
        self.id = id
        self.name = name
        self.who = who
        self.date = date
        self.description = description
        self.img = img
    }
}
