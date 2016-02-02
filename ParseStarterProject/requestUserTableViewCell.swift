//
//  requestUserTableViewCell.swift
//  vite1.1
//
//  Created by Sebastian Misas on 2/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class requestUserTableViewCell: UITableViewCell {
    @IBOutlet weak var reqeustUserThumbnail: UIImageView!
    @IBOutlet weak var requestUserName: UILabel!
    @IBAction func acceptInvite(sender: AnyObject) {
    }
    @IBAction func declineInvite(sender: AnyObject) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        reqeustUserThumbnail.layer.cornerRadius = reqeustUserThumbnail.frame.size.width/2
        reqeustUserThumbnail.clipsToBounds = true
//        acceptInvite.layer.cornerRadius = acceptInvite.frame.size.width/2
//        acceptInvite.clipsToBounds = true
//        declineInvite.layer.cornerRadius = declineInvite.frame.size.width/2
//        declineInvite.clipsToBounds = true
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
