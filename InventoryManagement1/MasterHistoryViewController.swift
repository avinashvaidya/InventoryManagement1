//
//  MasterHistoryViewController.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 7/8/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import UIKit

class MasterHistoryViewController: UITableViewController {
    
    var historyItems: [String] = ["Tech History","Device History"]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: HistoryCell = tableView.dequeueReusableCellWithIdentifier("HistoryCellId", forIndexPath: indexPath) as! HistoryCell
        cell.historyItem?.text = historyItems[indexPath.row]
        
        return cell
    }

}
