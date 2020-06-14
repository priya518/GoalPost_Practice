//
//  UIViewControllerExt.swift
//  Goalpost-App
//
//  Created by Priya patel on 08/06/20.
//  Copyright © 2020 Priya patel. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentSecondaryDeatail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        guard let presentedViewController = presentedViewController else { return }
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
        
    }
    
    func dismissDetail() {
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    
}
