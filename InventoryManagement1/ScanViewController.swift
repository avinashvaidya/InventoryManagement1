//
//  ScanViewController.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 6/12/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import UIKit
import CoreData



class ScanViewController: UIViewController {
    
    var techName: String!

    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var scanItem: UITextField!
   
    @IBOutlet weak var scanCount: UILabel!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = techName

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // to display the count of existing devices
        var localStorage = LocalStorage()
        var coreDataDeviceList = [NSManagedObject]()
        coreDataDeviceList = localStorage.getDeviceListForUser(techName)
        scanCount.text = String(coreDataDeviceList.count)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanAction(sender: AnyObject) {
        if (scanItem.text != nil && count(scanItem.text) >= 10){
            var localStorage = LocalStorage()
            scanCount.text = localStorage.saveDevice(scanItem.text, username: techName) as String
            scanItem.text = ""
        }
    }
   
    @IBAction func sendScanAction(sender: AnyObject) {
        var localStorage = LocalStorage()
        scanCount.text = localStorage.saveDevice(scanItem.text, username: techName) as String
        scanItem.text = ""
    }
    
    
    @IBAction func logoutAction(sender: AnyObject) {
        
        var loginVC = InventoryHelper().logoutEvent()
        self.presentViewController(loginVC, animated: true, completion: nil)
        
    }

}
