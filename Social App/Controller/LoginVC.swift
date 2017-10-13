//
//  LoginVC.swift
//  Social App
//
//  Created by PoGo on 10/12/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passwordField: InsetTextField!
    @IBOutlet weak var emailField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self

    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil{
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, loginComplete: { (success, loginError) in
                if success{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print(String(describing: loginError?.localizedDescription))
                    print("failed to login")
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registrationError) in
                    if success{
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, nil) in
                            print("Registered")
                        })
                    }else{
                        print(String(describing: registrationError?.localizedDescription))
                        print("Failed to register")
                    }
                })
            })
            
            
        }else{
            print("Enter username and password")
        }
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoginVC: UITextFieldDelegate{
    
    
    
    
    
}
