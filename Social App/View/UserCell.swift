//
//  UserCell.swift
//  Social App
//
//  Created by PoGo on 10/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var checkImage: UIImageView!
    var showing = false
    
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool){
        
        self.profileImage.image = image
        self.emailLabel.text = email
        if isSelected{
            checkImage.isHidden = false
        }else{
            checkImage.isHidden = true
        }
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected{
            if showing == false{
                checkImage.isHidden = false
                showing = true
            }else{
                checkImage.isHidden = true
                showing = false
            }
       
            
        }
    }

}
