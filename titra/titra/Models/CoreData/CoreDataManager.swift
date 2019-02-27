//
//  CoreDataManager.swift
//  titra
//
//  Created by Emerson Victor on 27/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    private let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    
    static let shared = CoreDataManager()
    
    private init() {
        self.appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        self.context = self.appDelegate.persistentContainer.viewContext
    }
    
    func getManagedObject(forEntityName entityName: String) -> NSManagedObject? {
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            return nil
        }
        
        let object = NSManagedObject(entity: entity, insertInto: self.context)
        
        return object
    }
    
    func fetchObjects(forEntity entityName: String, withPredicates predicates: [NSPredicate] = []) -> [NSManagedObject] {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        var objetcs: [NSManagedObject] = []
        
        
        do {
            objetcs = try self.context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return objetcs
    }
}

