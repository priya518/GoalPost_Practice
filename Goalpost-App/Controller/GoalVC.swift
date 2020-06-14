//
//  ViewController.swift
//  Goalpost-App
//
//  Created by Priya patel on 06/06/20.
//  Copyright © 2020 Priya patel. All rights reserved.
//

import UIKit
import CoreData

let appdelegate = UIApplication.shared.delegate as? AppDelegate

class GoalVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
        
        
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                }
                else{
                    tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        presentDetail(createGoalVC)
    }
    
}

extension GoalVC: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
    
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return UITableViewCell.EditingStyle.none
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexpath) in
            
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexpath) in
            
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
       
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
        return [deleteAction, addAction]
    }
}

extension GoalVC {
    func setProgress(atIndexPath indexpath: IndexPath) {
        
        guard let managedContext = appdelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexpath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
        }else {
            return
        }
        
        do {
            try managedContext.save()
            print("Successfully set progress")
        } catch  {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
        
    
    }
    
    func removeGoal(atIndexPath indexpath: IndexPath) {
        
        guard let managedContext = appdelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goals[indexpath.row])
        
        do {
            try managedContext.save()
            print("Successfully remove")
        } catch  {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
        
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        
        guard let managedContext = appdelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest) as! [Goal]
            print("Successfully fetch data")
            completion(true)
        } catch  {
            debugPrint("Could not fetch data: \(error.localizedDescription)")
            completion(false)
        }
        
    }
}

