//
//  AuthVC.swift
//  Social App
//
//  Created by PoGo on 10/12/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil{
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func signInWithEmailButtonPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func signInWithFbButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signInWithGoogleButtonPressed(_ sender: Any) {
    
        
    }
    
    
}


