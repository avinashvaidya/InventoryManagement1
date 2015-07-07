//
//  CoreDataDao.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 7/1/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import Cocoa


class CoreDataDao: NSObject {
    
    let managedApplicationContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    /*
    * This method saves the data in core data
    */
    func saveDevice(serialNumber: String){
        
        let managedApplicationContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let deviceEntity = NSEntityDescription.insertNewObjectForEntityForName("Devices", inManagedObjectContext: managedApplicationContext!) as! Devices
        deviceEntity.serialNumber = serialNumber
        deviceEntity.createdDate = NSDate()
        
        var error: NSError?
        if !managedApplicationContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
    }


}
