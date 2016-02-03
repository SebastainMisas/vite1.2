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
    @IBOutlet weak var declineInviteBtn: UIButton!
    @IBOutlet weak var acceptInviteBtn: UIButton!
    @IBAction func acceptInvite(sender: AnyObject) {
    }
    @IBAction func declineInvite(sender: AnyObject) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        reqeustUserThumbnail.layer.cornerRadius = reqeustUserThumbnail.frame.size.width/2
        reqeustUserThumbnail.clipsToBounds = true
        acceptInviteBtn.layer.cornerRadius = acceptInviteBtn.frame.size.width/2
        acceptInviteBtn.clipsToBounds = true
        declineInviteBtn.layer.cornerRadius = declineInviteBtn.frame.size.width/2
        declineInviteBtn.clipsToBounds = true
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
