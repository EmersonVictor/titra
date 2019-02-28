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
    let id: NSManagedObjectID?
    var name: String
    let createdAt: Date
    var expectedExecutionTime: Int32
    var isCompleted: Bool
    
    // MARK: - Initializers
    init(name: String, createdAt: Date, expectedExecutionTime: Int32, isCompleted: Bool = false) {
        self.id = nil
        self.name = name
        self.createdAt = createdAt
        self.expectedExecutionTime = expectedExecutionTime
        self.isCompleted = isCompleted
    }
    
    init(task: NSManagedObject) {
        self.id = task.objectID
        self.name = task.value(forKey: "name") as! String
        self.createdAt = task.value(forKey: "createdAt") as! Date
        self.expectedExecutionTime = task.value(forKey: "expectedExecutionTime") as! Int32
        self.isCompleted = task.value(forKey: "isCompleted") as! Bool
    }
    
    // MARK: - Save task
    func save() {
        // Create CoreData manager and get the managed object
        let manager = CoreDataManager.shared
        
        guard let task = manager.getManagedObject(forEntityName: "TaskMO", withID: self.id) else {
            return
        }
        
        // Set object value to managed object
        task.setValue(self.name, forKey: "name")
        task.setValue(self.createdAt, forKey: "createdAt")
        task.setValue(self.expectedExecutionTime, forKey: "expectedExecutionTime")
        task.setValue(self.isCompleted, forKey: "isCompleted")
        
        // Catch CoreData save error
        do {
            try manager.context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
