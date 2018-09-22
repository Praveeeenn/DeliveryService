//
//  Delivery.swift
//  Delivery Service
//
//  Created by apple on 16/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import Foundation

class Delivery: Codable {
    
    var id: Int?
    var description: String?
    var imageUrl: String?
    
    var location: Location?
}
