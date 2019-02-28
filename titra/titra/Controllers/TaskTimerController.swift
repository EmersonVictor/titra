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
    var task: Task? = nil
    var taskTimer = TaskTimer(executionTime: -1, expiredTime: 0)
    var previousTimers: [TaskTimer] = []
    var timer = Timer()
    var isRunning = false
    
    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.previousTimersTableView.dataSource = self
        self.previousTimersTableView.delegate = self
        self.updateTimers()
        
        // Set task timer information
        if let task = self.task {
            self.taskNameLabel.text = task.name
            self.timerLabel.text = TimerFormatter.format(task.expectedExecutionTime, toUnits: [.hour, .minute, .second], withStyle: .positional)
        }
    }
    
    // MARK: - Timer actions
    @IBAction func startTimer() {
        // Create timer
        self.isRunning = true
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: self.isRunning) { (timer) in
            self.taskTimer.executionTime += 1
            self.timerLabel.text = TimerFormatter.format(self.taskTimer.executionTime, toUnits: [.hour, .minute, .second], withStyle: .positional)
            
            if self.taskTimer.executionTime <= self.task!.expectedExecutionTime {
                self.timerLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            } else {
                self.timerLabel.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                self.taskTimer.expiredTime += 1
            }
        }
        
    }
    
    @IBAction func pauseTimer() {
        // Pause timer
        self.isRunning = false
    }
    
    @IBAction func stopTimer() {
        // Stop timer
        self.isRunning = false
        self.timer.invalidate()
        self.taskTimer = TaskTimer(executionTime: -1, expiredTime: 0)
        
        // Remove label color
        self.timerLabel.textColor = UIColor.black
        
        // Update timer label
        self.timerLabel.text = TimerFormatter.format(self.task!.expectedExecutionTime, toUnits: [.hour, .minute, .second], withStyle: .positional)
        
        // Save timer
        self.taskTimer.save()
        
        // Update timers table
        self.updateTimers()
        
    }
    
    // MARK: - Update tasks
    func updateTimers() {
        let predicate = NSPredicate(format: "task == %@", (self.task!.id)!)
        
        CoreDataManager.shared.fetchObjects(forEntity: "TimerMO",completion: { (timers) in
            self.previousTimers = timers.map {  TaskTimer(timer: $0) }
        }) { (_) in
            print("Ops, an error")
        }
        
        self.previousTimersTableView.reloadData()
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
