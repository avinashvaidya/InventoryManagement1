//
//  LocalStorage.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 7/1/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import UIKit
import CoreData

class LocalStorage: NSObject {
    
    let managedApplicationContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var coreDataDeviceList = [Devices]()
    
    /*
    * This method saves the data in core data
    */
    func saveDevice(serialNumber: String, username: String) -> NSString{
        
        let deviceEntity = NSEntityDescription.insertNewObjectForEntityForName("Devices", inManagedObjectContext: managedApplicationContext!) as! Devices
        deviceEntity.serialNumber = serialNumber
        deviceEntity.createdDate = NSDate()
        deviceEntity.user = username
        
        
        var error: NSError?
        if !managedApplicationContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        let fetchRequest = NSFetchRequest(entityName: "Devices")
        // Execute the fetch request, and cast the results to an array of Devices objects
        self.coreDataDeviceList =  (managedApplicationContext!.executeFetchRequest(fetchRequest, error: nil) as? [Devices])!
       
        return String(coreDataDeviceList.count)
        
    }
    
    
    func getDeviceCount() -> NSString{
        
        let fetchRequest = NSFetchRequest(entityName: "Devices")
        // Execute the fetch request, and cast the results to an array of Devices objects
        self.coreDataDeviceList =  (managedApplicationContext!.executeFetchRequest(fetchRequest, error: nil) as? [Devices])!
        
        return String(coreDataDeviceList.count)
        
    }
    
    
    func getDeviceListForUser(username: String) -> [Devices]{
        
        let fetchRequest = NSFetchRequest(entityName: "Devices")
        var devicePredicate = NSPredicate(format: "user == %@", username)
        fetchRequest.predicate = devicePredicate
         self.coreDataDeviceList =  (managedApplicationContext!.executeFetchRequest(fetchRequest, error: nil) as? [Devices])!
        return coreDataDeviceList
    }
    
    func deleteDeviceList(){
        let fetchRequest = NSFetchRequest(entityName: "Devices")
        // Execute the fetch request, and cast the results to an array of Devices objects
        self.coreDataDeviceList =  (managedApplicationContext!.executeFetchRequest(fetchRequest, error: nil) as? [Devices])!
        managedApplicationContext?.delete(coreDataDeviceList)
    }
    
    func deleteDeviceFromList(rowIndex: Int) -> Bool{
        var deleteSuccess = false
        var error: NSError?
        let fetchRequest = NSFetchRequest(entityName: "Devices")
        //var devicePredicate = NSPredicate(format: "serialNumber == %@", serialNum)
        self.coreDataDeviceList =  (managedApplicationContext!.executeFetchRequest(fetchRequest, error: nil) as? [Devices])!
        managedApplicationContext?.deleteObject(coreDataDeviceList[rowIndex] as Devices)
        if (!managedApplicationContext!.save(&error)){
            println("Could not save \(error), \(error?.userInfo)")
        }else{
            deleteSuccess = true
        }
        
        return deleteSuccess
    }
    
    
    func saveUser(username: String){
        let loginEntity = NSEntityDescription.insertNewObjectForEntityForName("Login", inManagedObjectContext: managedApplicationContext!) as! Login
        loginEntity.username = username
        var error: NSError?
        if !managedApplicationContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    
    }

}
