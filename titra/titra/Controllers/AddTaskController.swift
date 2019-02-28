//
//  AddTaskController.swift
//  titra
//
//  Created by Emerson Victor on 26/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit
import CoreData

class AddTaskController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    // MARK: - Variables
    var task: Task? = nil
    
    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = self.task {
            self.nameTextField.text = task.name
            self.timerPicker.countDownDuration = TimeInterval(task.expectedExecutionTime)
        } else {
            self.timerPicker.countDownDuration = 900
        }
        
        
    }
    
    // MARK: - Save taks creation and edition
    @IBAction func saveTask(_ sender: Any) {
        
        // Validation
        guard let name = self.nameTextField.text, !((self.nameTextField.text?.isEmpty)!) else {
            print("A task need to have a name")
            return
        }
        
        
        // Save on core data
        let time = Int32(self.timerPicker.countDownDuration)
        
        if let task = self.task {
            task.name = name
            task.expectedExecutionTime = time
            task.save()
        } else {
            let task = Task(name: name, createdAt: Date(), expectedExecutionTime: time)
            task.save()
        }
        
        
        
        // Back to root view controller
        navigationController?.popToRootViewController(animated: true)
    }
}
