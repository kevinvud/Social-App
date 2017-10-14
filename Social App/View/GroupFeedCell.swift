//
//  GroupFeedCell.swift
//  Social App
//
//  Created by PoGo on 10/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    func configureCell(profileImage: UIImage, email: String, message: String){
        
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.messageLabel.text = message
        
        
    }
    
}
