//
//  Devices.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 7/1/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import Foundation
import CoreData

class Devices: NSManagedObject {

    @NSManaged var serialNumber: String
    @NSManaged var createdDate: NSDate

}
