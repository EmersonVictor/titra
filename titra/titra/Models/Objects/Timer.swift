//
//  Timer.swift
//  titra
//
//  Created by Emerson Victor on 27/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import Foundation
import CoreData

class Timer {
    let executionTime: Date
    let expiredTime: Date
    
    init(executionTime: Date, expiredTime: Date) {
        self.executionTime = executionTime
        self.expiredTime = expiredTime
    }
    
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
