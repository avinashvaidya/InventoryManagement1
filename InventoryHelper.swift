//
//  InventoryHelper.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 7/1/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import UIKit

class InventoryHelper: NSObject {
    
    func logoutEvent() ->UIViewController{
        
        var mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginVC = mainStoryBoard.instantiateViewControllerWithIdentifier("loginViewController") as! ViewController
        
        return loginVC

    }

}
