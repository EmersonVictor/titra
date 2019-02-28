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
    
    // MARK: - Initializer
    private init() {
        self.appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        self.context = self.appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Get managed object (with id)
    func getManagedObject(forEntityName entityName: String, withID objectId: NSManagedObjectID? = nil) -> NSManagedObject? {
        
        if let id = objectId {
            // Get existing managed object
            return self.context.object(with: id)
            
        } else {
            // Create new managed object
            guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
                return nil
            }
            
            let object = NSManagedObject(entity: entity, insertInto: self.context)
            
            return object
        }
    }
    
    // MARK: - Fetch objects (with predicates)
    func fetchObjects(forEntity entityName: String, withPredicates predicate: NSPredicate? = nil, completion: (_ objects: [NSManagedObject]) -> Void, error:  (_ error: NSError?) -> Void) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        // Add predicate
        if let filter = predicate {
            fetchRequest.predicate = filter
        }
        
        // Fetch request
        do {
            let objetcs = try self.context.fetch(fetchRequest)
            completion(objetcs)
            
        } catch let fetchError as NSError {
            error(fetchError)
        }
    }
}

