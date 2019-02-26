//
//  TaskTimerController.swift
//  titra
//
//  Created by Emerson Victor on 26/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit

class TaskTimerController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var previousTimersTableView: UITableView!
    
    // MARK - Variables
    var isPaused = false
    let previousTimers = ["test"]
    
    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.previousTimersTableView.dataSource = self
        self.previousTimersTableView.delegate = self
    }
    
    // MARK: - Timer actions
    @IBAction func startTimer() {
    }
    
    @IBAction func pauseTimer() {
    }
    
    @IBAction func stopTimer() {
    }
}

extension TaskTimerController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.previousTimers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "previousTimer")
        
        return cell!
    }
    
    
}

extension TaskTimerController: UITableViewDelegate {
    
}
