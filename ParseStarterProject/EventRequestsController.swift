//
//  EventRequestsController.swift
//  vite1.1
//
//  Created by Sebastian Misas on 2/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class EventRequestsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBAction func backBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
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
    let image1 = UIImage(named: "12294663_10203804687677120_2383926010236257492_n")
    let name1 = "sebastain"
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableViewArray.count
                return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let requestUserCell = tableView.dequeueReusableCellWithIdentifier("requestUserCell", forIndexPath: indexPath) as! requestUserTableViewCell
        

        requestUserCell.reqeustUserThumbnail.image =  image1
        requestUserCell.requestUserName.text = name1
        
        return requestUserCell
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}

