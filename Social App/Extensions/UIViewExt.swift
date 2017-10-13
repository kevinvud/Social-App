//
//  UIViewExt.swift
//  Social App
//
//  Created by PoGo on 10/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

extension UIView{
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
        
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification){
        //same duration as keyboard duration
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        //same animattion as keyboard
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
       
        //get the change in Y axis
        
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
    
    
    
}
