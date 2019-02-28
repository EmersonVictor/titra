//
//  MainController.swift
//  titra
//
//  Created by Emerson Victor on 26/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit
import CoreData

class TasksController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tasksTableView: UITableView!
    
    // MARK: - Variables
    var tasks: [Task] = []
    
    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tasksTableView.dataSource = self
        self.tasksTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateTasks()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskTimer" {
            let controller = segue.destination as! TaskTimerController
            
            // Send selected task
            let selectedTask = sender as! Int
            controller.task = tasks[selectedTask]
            
        } else if segue.identifier == "createUpdateTask" {
            if let taskPosition = sender as? Int {
                let controller = segue.destination as! AddTaskController
                
                // Send selected task
                controller.task = tasks[taskPosition]
            }
        }
    }
    
    // MARK: - Update tasks
    func updateTasks() {
        let predicate = NSPredicate(format: "isCompleted = %@", NSNumber(value: false))
        
        CoreDataManager.shared.fetchObjects(forEntity: "TaskMO", withPredicates: predicate,completion: { (tasks) in
            self.tasks = tasks.map { Task(task: $0) }
        }) { (_) in
            print("Ops, an error")
        }
        
        self.tasksTableView.reloadData()
    }
}

extension TasksController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task")
        let task = tasks[indexPath.row]
        
        cell?.textLabel?.text = task.name
        cell?.detailTextLabel?.text = TimerFormatter.format(task.expectedExecutionTime, toUnits: [.hour, .minute])
        cell?.selectionStyle = .none
        
        return cell!
    }
}

extension TasksController: UITableViewDelegate {
    // MARK: - Cell selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "taskTimer", sender: indexPath.row)
    }
    
    // MARK: - Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - Table view swipe actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = self.completeAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [complete])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = self.updateAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [update])
    }
    
    // MARK: - Swipe contextual actions
    // Complete action
    func completeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Done") { (action, view, completion) in
            // Get the task and remove from tasks array
            let task = self.tasks.remove(at: indexPath.row)
            
            // Remove task from tablew view
            self.tasksTableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Complete task and update table
            task.isCompleted = !(task.isCompleted)
            task.save()
            
            completion(true)
        }
        
        // Action interface
        action.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        action.title = "✔︎"

        return action
    }

    // Update action
    func updateAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            self.performSegue(withIdentifier: "createUpdateTask", sender: indexPath.row)
        }
        
        // Action interface
        action.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        return action
    }
}
