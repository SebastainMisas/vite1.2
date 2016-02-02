//
//  EventRequestsController.swift
//  vite1.1
//
//  Created by Sebastian Misas on 2/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class EventRequestsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change dictionary items with users data
        let userRequestingForEvent:NSDictionary = ["userImage": "image"]
        
        tableViewArray.append("red")
        tableViewArray.append("blue")
        tableViewArray.append("green")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var tableViewArray = [String]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArray.count
        //        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tempcell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifer", forIndexPath: indexPath)
        
        tempcell.textLabel?.text = tableViewArray[indexPath.row]
        return tempcell
    }
    
    
}

