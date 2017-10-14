//
//  GroupVCCell.swift
//  Social App
//
//  Created by PoGo on 10/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class GroupVCCell: UITableViewCell {

    @IBOutlet weak var groupTitleLabel: UILabel!
    
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    
    @IBOutlet weak var groupMembersLabel: UILabel!
    
    
    func configureCell(title: String, description: String, memberCount: Int){
        
        self.groupTitleLabel.text = title
        self.groupDescriptionLabel.text = description
        self.groupMembersLabel.text = "\(memberCount) members."
    }
    
}
