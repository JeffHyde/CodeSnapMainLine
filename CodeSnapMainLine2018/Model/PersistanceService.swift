//
//  PesistanceService.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/13/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import Foundation
import CoreData

struct PersistanceService {

    private init() {}
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CodeSnapMainLine2018")
      
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("Load Persistant Container Error: \(error)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    static func saveContext (completion:@escaping (()->()), errorCompletion:@escaping(()->())) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion()
            } catch let error {
                print("Save Persistant Container Error: \(error)")
                errorCompletion()
            }
        }
    }
  
}
