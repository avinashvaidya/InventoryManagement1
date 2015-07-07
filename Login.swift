//
//  Login.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 7/1/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import Foundation
import CoreData

class Login: NSManagedObject {

    @NSManaged var password: String
    @NSManaged var username: String
    @NSManaged var userToDevices: NSOrderedSet

}
