//
//  ChatCell.swift
//  ParseChat
//
//  Created by Jessica Yeh on 6/26/17.
//  Copyright © 2017 Jessica Yeh. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
