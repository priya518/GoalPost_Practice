//
//  UIViewExt.swift
//  Goalpost-App
//
//  Created by Priya patel on 09/06/20.
//  Copyright © 2020 Priya patel. All rights reserved.
//

import UIKit

extension UIView {
    
    func bindToKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
         let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
         let beginningFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
         let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
         let deltaY = endFrame.origin.y - beginningFrame.origin.y

         UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
             self.frame.origin.y += deltaY
         }, completion: nil)
        
    }
}
