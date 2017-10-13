//
//  CreatePostVC.swift
//  Social App
//
//  Created by PoGo on 10/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self

    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here..."{
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete{
                    self.sendButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("There was an error!")
                }
            })
        }
    }
    
    @IBOutlet weak var closeButtonPressed: UIButton!
    
}

extension CreatePostVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
