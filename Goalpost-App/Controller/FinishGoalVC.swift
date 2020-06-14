//
//  FinishGoalVC.swift
//  Goalpost-App
//
//  Created by Priya patel on 10/06/20.
//  Copyright © 2020 Priya patel. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        
        self.goalDescription = description
        self.goalType = type
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
    }
    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        //Pass data into Core Data Goal Model
        if pointsTextField.text != ""
        {
            self.save { (complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(complition: (_ finished: Bool) -> ()) {
        guard let managedContext = appdelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDiscription = goalDescription
        goal.goalType = goalType.map { $0.rawValue }
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("Successfully saved data")
            complition(true)
        } catch  {
            debugPrint("Could not save \(error.localizedDescription)")
            complition(false)
        }
        
    }
}
