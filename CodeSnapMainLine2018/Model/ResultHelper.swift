//
//  ResultHelper.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/29/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import Foundation

class ResultHelper {
    static func chosenFixtures() -> [Fixture] {
        var chosenFixtures = [Fixture]()
        let allFixtures = Array<Fixture>.fixturesSorted()
        for item in allFixtures {
            if item.fixtureCount > 0 {
                chosenFixtures.append(item)
            }
        }
        return chosenFixtures
    }
    
    static func measurmentArray(actualPsi: Double,
                                psi: Double,
                                height: Double,
                                distance: Double) -> [String] {
        return [
            "Actual P.S.I.  \(String(describing: actualPsi))",
            "P.S.I.  \(String(describing: Int(psi)))",
            "Elevation  \(String(describing: Int(height)))'",
            "Distance  \(String(describing: Int(distance)))'"
        ]
    }
    
    static func getTotalFixtureUnits(chosenFixtures: [Fixture]) -> Double {
        var totals = [Double]()
        for item in chosenFixtures {
            let count = item.fixtureCount
            let units = item.units
            let totalUnits = Double(count) * units
            totals.append(totalUnits)
        }
        var totalUnits = Double()
        for item in totals {
            totalUnits += item
        }
        return totalUnits
    }
    
    static func actualPsi(psi: Double,
                          height: Double) -> Double {
        if height <= -1.0 {
            return psi + 0.5 * abs(Double(height))
        } else if height >= 1.0 {
            return psi - 0.5 * abs(Double(height))
        } else if height == 0 {
            return psi
        } else {
            return 0.0
        }
    }
    
    static func meterSize(answer: [String]) -> [String] {
        let meter = "Meter:  \(answer[0])"
        let main = "Main & Branch Lines:  \(answer[1])"
        
        if meter == "Meter: Low Pressure" {
            return ["low"]
        } else if meter == "Meter: Over Limit" {
            return ["over limit"]
        } else {
            return [meter,main]
        }
    }
}
