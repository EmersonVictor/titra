//
//  Task.swift
//  titra
//
//  Created by Emerson Victor on 27/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import Foundation
import CoreData

class Task {
    let name: String
    let createdAt: Date
    let expectedExecutionTime: Date
    
    init(name: String, createdAt: Date, expectedExecutionTime: Date) {
        self.name = name
        self.createdAt = createdAt
        self.expectedExecutionTime = expectedExecutionTime
    }
    
    // Save task
    func save() {
        // Create CoreData manager and get the managed object
        let manager = CoreDataManager.shared
        guard let task = manager.getManagedObject(forEntityName: "TaskMO") else {
            return
        }
        
        // Set object value to managed object
        task.setValue(self.name, forKey: "name")
        task.setValue(self.createdAt, forKey: "createdAt")
        task.setValue(self.expectedExecutionTime, forKey: "expectedExecutionTime")
        
        // Catch CoreData save error
        do {
            try manager.context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
