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
    
    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Save taks creation and edition
    @IBAction func saveTask(_ sender: Any) {
        
        // Validation
        guard let name = self.nameTextField.text else {
            print("A task need to have a name")
            return
        }
        
        // Save on core data
        let task = Task(name: name, createdAt: Date(), expectedExecutionTime: Date())
        task.save()
        
        // Back to root view controller
        navigationController?.popToRootViewController(animated: true)
    }
}
