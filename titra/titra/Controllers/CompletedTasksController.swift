//
//  FinishedTasksController.swift
//  titra
//
//  Created by Emerson Victor on 26/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit

class CompletedTasksController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var completedTasksTableView: UITableView!
    
    // MARK: - Variables
    let completedTasks = ["test"]
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        self.completedTasksTableView.dataSource = self
        self.completedTasksTableView.delegate = self
    }
}

extension CompletedTasksController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.completedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task")
        
        return cell!
    }
}

extension CompletedTasksController: UITableViewDelegate {
    
}
