//
//  DeviceDetailController.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 7/6/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import UIKit
import CoreData

class DeviceDetailController: UIViewController {
    
    var serialNum: String!

    @IBOutlet weak var serialNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        serialNumber.text = serialNum
    }
    
}
