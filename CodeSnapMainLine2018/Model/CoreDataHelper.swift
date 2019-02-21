//
//  CoreDataHelper.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/13/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    class func getEntity<T: NSManagedObject>(entity: T.Type) -> [T] {
        var result = [T]()
        let entityName = String(describing: entity)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            let data = try PersistanceService.context.fetch(fetchRequest)
            result = data
        } catch let error {
            print("Core Data Error Getting Entity: \(error)")
        }
        return result
    }
    
    class func saveMeasurementValue(indexPath: Int16,
                                     valueToSave value: Double) {
        let arrayOfMeasurements = CoreDataHelper.getEntity(entity: Measurements.self) as [Measurements]
        let measurement = arrayOfMeasurements.first {$0.orderIndex == indexPath}
        print("MVALUE: \(String(describing: measurement?.value)) \(value)")
        measurement?.value = value
        PersistanceService.saveContext(completion: {
        }, errorCompletion: {
        })
    }
    
    class func saveFixtureCount(indexPath: Int,
                                 valueToSave count: Int16) {
        let arrayOfFixtures = CoreDataHelper.getEntity(entity: Fixture.self) as [Fixture]
        let fixture = arrayOfFixtures.first {$0.orderIndex == indexPath}
        fixture?.fixtureCount = count
        PersistanceService.saveContext(completion: {
        }, errorCompletion: {
        })
    }
    
}

extension Array {
    static func measurmentsSorted() -> [Measurements] {
        let measurmentData = CoreDataHelper.getEntity(entity: Measurements.self) as [Measurements]
        return  measurmentData.sorted(by: {$0.orderIndex < $1.orderIndex})
    }
    static func fixturesSorted() -> [Fixture] {
        let fixtureData = CoreDataHelper.getEntity(entity: Fixture.self) as [Fixture]
        return  fixtureData.sorted(by: {$0.orderIndex < $1.orderIndex})
    }
}
