//
//  MainController.swift
//  titra
//
//  Created by Emerson Victor on 26/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit

class TasksController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tasksTableView: UITableView!
    
    // MARK: - Variables
    let tasks = ["test"]
    
    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tasksTableView.dataSource = self
        self.tasksTableView.delegate = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
        }
        
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
}
