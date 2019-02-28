//
//  Timer.swift
//  titra
//
//  Created by Emerson Victor on 27/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import Foundation
import CoreData

class TaskTimer {
    var executionTime: Int32
    var expiredTime: Int32
    
    // MARK: - Initializers
    init(executionTime: Int32, expiredTime: Int32) {
        self.executionTime = executionTime
        self.expiredTime = expiredTime
    }
    
    init(timer: NSManagedObject) {
        self.executionTime = timer.value(forKey: "executionTime") as! Int32
        self.expiredTime = timer.value(forKey: "expiredTime") as! Int32
    }

    // MARK: - Save object
    func save() {
        // Create CoreData manager and get the managed object
        let manager = CoreDataManager.shared
        guard let timer = manager.getManagedObject(forEntityName: "TimerMO") else {
            return
        }
        
        // Set object value to managed object
        timer.setValue(self.executionTime, forKey: "executionTime")
        timer.setValue(self.expiredTime, forKey: "expiredTime")
        
        // Catch CoreData save error
        do {
            try manager.context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
