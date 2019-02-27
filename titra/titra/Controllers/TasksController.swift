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
    var tasks: [NSManagedObject] = []
    
    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tasksTableView.dataSource = self
        self.tasksTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateTasks()
    }
    
    // MARK: - Update tasks
    func updateTasks() {
        self.tasks = CoreDataManager.shared.fetchObjects(forEntity: "TaskMO")
        self.tasksTableView.reloadData()
    }
}

extension TasksController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "")
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "completedTasks")
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "task")
            
            let task = tasks[indexPath.row - 1]
            
            cell?.textLabel?.text = task.value(forKey: "name") as? String
        }
        
        cell?.selectionStyle = .none
        
        return cell!
    }
}

extension TasksController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "completedTasks", sender: nil)
        } else {
            self.performSegue(withIdentifier: "taskTimer", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
