//
//  CreateGroupVC.swift
//  Social App
//
//  Created by PoGo on 10/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

    @IBOutlet weak var groupNameField: InsetTextField!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var descriptionField: InsetTextField!
    
    @IBOutlet weak var addPeopleField: InsetTextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMemberLabel: UILabel!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addPeopleField.delegate = self
        addPeopleField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
        
        
    }
    @objc func textFieldDidChange(){
        if addPeopleField.text == ""{
            emailArray = []
            tableView.reloadData()
        } else{
            DataService.instance.getEmail(forSearchQuery: addPeopleField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
        
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension CreateGroupVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if chosenUserArray.contains(emailArray[indexPath.row]){
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        }else{
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !chosenUserArray.contains(cell.emailLabel.text!){
            chosenUserArray.append(cell.emailLabel.text!)
            groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
            doneButton.isHidden = false
        }else{
            chosenUserArray = chosenUserArray.filter({$0 != cell.emailLabel.text!})
            if chosenUserArray.count >= 1{
                groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
            }else{
                groupMemberLabel.text = "add people to your group"
                doneButton.isHidden = true
            }
        }
        
        
    }
    
}

extension CreateGroupVC: UITextFieldDelegate{
    
    
    
}



