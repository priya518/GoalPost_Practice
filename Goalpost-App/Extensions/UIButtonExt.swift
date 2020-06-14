//
//  UIButtonExt.swift
//  Goalpost-App
//
//  Created by Priya patel on 09/06/20.
//  Copyright © 2020 Priya patel. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.8666666667, blue: 0.6862745098, alpha: 1)
    }
}
