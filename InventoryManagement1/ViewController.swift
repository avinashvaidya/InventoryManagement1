//
//  ViewController.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 6/11/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, RESTApiControllerProtocol {
    

    lazy var api: RESTApiController = RESTApiController(delegate: self)
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginError: UILabel!
    
    var isLoginSuccess: Bool = false
    
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
       super.viewDidAppear(animated)
        
        
    }
    
        
    func didReceiveApiResults(results: NSDictionary)  {
        println(results)
        
        var success: Bool = (results["authenticated"] as? Bool)!
        self.isLoginSuccess = success
        NSOperationQueue.mainQueue().addOperationWithBlock {
        if success{
            self.shouldPerformSegueWithIdentifier("loginSuccessSegue", sender: self)
            self.performSegueWithIdentifier("loginSuccessSegue", sender: self)
            var localStorage = LocalStorage()
            localStorage.saveUser(self.username.text)
          }else{
            let alert = UIAlertView()
            alert.title = "Incorrect credentials"
            alert.message = "Please Enter correct username and password"
            alert.addButtonWithTitle("Ok")
            alert.show()
         }
        }
    }
   

  
    @IBAction func loginAction(sender: AnyObject) {
        
        if username.text.isEmpty || password.text.isEmpty   {
            let alert = UIAlertView()
            alert.title = "Incorrect credentials"
            alert.message = "Please Enter username and password"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }else{
            var loginData: LoginData = LoginData()
            loginData.username = username.text
            loginData.password = password.text
            var isAuthenticated: Bool = false
            
            api.authenticateUser(loginData)
           
        }
        
    }
    
    private func validateCred(username: String, password: String) -> Bool{
     return false
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if self.isLoginSuccess {
            return true
        } else{
            return false
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "loginSuccessSegue" {
            var destinationTabVC : UITabBarController = segue.destinationViewController as! UITabBarController
            var scanNavVC = destinationTabVC.viewControllers![0] as! UINavigationController
            var scanTabVC = scanNavVC.viewControllers[0] as! ScanViewController
            var reportNavVC = destinationTabVC.viewControllers![1] as! UINavigationController
            var reportTabVC = reportNavVC.viewControllers![0] as! ReportViewController
            scanTabVC.techName = username.text
            reportTabVC.techName = username.text
            
        }
    
    }
}