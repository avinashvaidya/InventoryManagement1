//
//  ReportViewController.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 6/12/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import UIKit
import CoreData


class ReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var username: UILabel!
    
    var techName: String!

    @IBOutlet weak var tableView: UITableView!
    
    var coreDataDeviceList = [Devices]()
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = techName
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.registerClass(UITableViewCell(), forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func logoutAction(sender: AnyObject) {
        var loginVC = InventoryHelper().logoutEvent()
        self.presentViewController(loginVC, animated: true, completion: nil)
    }
    

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            var localStorage = LocalStorage()
            coreDataDeviceList = localStorage.getDeviceListForUser(username.text!)
            return (coreDataDeviceList.count)
            
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let cell: DeviceCell =
            tableView.dequeueReusableCellWithIdentifier("DeviceCellId")
                as! DeviceCell
            var device: Devices = coreDataDeviceList[indexPath.row]
            cell.serialNumber!.text = device.serialNumber
            return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            // TODO: implement the logic to delete the row
            var localStorage = LocalStorage()
            println(coreDataDeviceList[indexPath.row].serialNumber)
            
            var deleteSuccess = localStorage.deleteDeviceFromList(indexPath.row)
            if deleteSuccess{
            coreDataDeviceList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            //self.tableView.reloadData()
        }
    }
        
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "DeviceDetailIdentifier"{
        if let deviceDetailVC = segue.destinationViewController as? DeviceDetailController{
            if let deviceIndex = tableView.indexPathForSelectedRow()?.row{
                deviceDetailVC.serialNum = coreDataDeviceList[deviceIndex].serialNumber
            }
        }
        }
        
    }
    
    

}
