//
//  GoalCell.swift
//  Goalpost-App
//
//  Created by Priya patel on 07/06/20.
//  Copyright © 2020 Priya patel. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    func configureCell(goal: Goal)
    {
        
        self.goalDescriptionLbl.text = goal.goalDiscription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        }else {
            self.completionView.isHidden = true
        }
        
        
        
        
    }
    

    
    
    
}
