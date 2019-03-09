//
//  chatRoomTableCell.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 2/27/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import UIKit

class chatRoomTableCell: UITableViewCell {

    @IBOutlet weak var chatHandle: UILabel!
    @IBOutlet weak var chatMessage: UILabel!
    
    func setPost(handle: String, message: String){
        chatHandle.text = handle
        chatMessage.text = message
    }
}
