//
//  GroupFeedVCViewController.swift
//  Social App
//
//  Created by PoGo on 10/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    @IBOutlet weak var memberLabel: UILabel!
    
    @IBOutlet weak var tableViewView: UIView!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    var group: Group?
    var groupMessages = [Message]()
    
    func initData(forGroup group: Group){
        self.group = group
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//            tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 80
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
      
        groupTitleLabel.text = group?.groupTitle
        DataService.instance.getEmailsForGroup(group: group!) { (returnedEmails) in
            self.memberLabel.text = returnedEmails.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesForGroup(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0{
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0) , at: .bottom, animated: false)
                
                }
            })
        }
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        if messageTextField.text != ""{
            messageTextField.isEnabled = false
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key, sendComplete: { (complete) in
                if complete{
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendButton.isEnabled = true
                }
            })
            
            
            
        }
        
        
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? GroupFeedCell else {return UITableViewCell()}
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, message: message.content)
        }
        
        return cell
        
    }
    
}

extension GroupFeedVC: UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        self.sendBtnView.bindToKeyboard()
        
        //self.tableViewView.bindToKeyboard()
//        if self.groupMessages.count > 0{
//            let indexPath = IndexPath(row: self.groupMessages.count - 1, section: 0)
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.sendBtnView.removeObser()
        self.tableView.removeObser()
        if self.groupMessages.count > 0{
            self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0) , at: .bottom, animated: false)
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextField.resignFirstResponder()
        return true
    }
    
    
    
    
}
