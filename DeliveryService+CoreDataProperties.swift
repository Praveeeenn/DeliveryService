//
//  DeliveryService+CoreDataProperties.swift
//  Delivery Service
//
//  Created by apple on 22/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//
//

import Foundation
import CoreData


extension DeliveryService {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeliveryService> {
        return NSFetchRequest<DeliveryService>(entityName: "DeliveryService")
    }

    @NSManaged public var json: NSData?

}
