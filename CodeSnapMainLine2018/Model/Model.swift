//
//  Helpers.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 7/23/18.
//  Copyright © 2018 Jeff  Hyde. All rights reserved.
//

import Foundation
import UIKit

struct Segue {
    static let psi = "ShowPSISegueID"
    static let distance = "ShowDistanceSegueID"
    static let fixtures = "ShowFixturesSegueID"
    static let result = "ResultsSegueID"
    
}

struct LinksData {
    static let sourceLink = SourceLink(name: "610.8",
                                       link: "http://epubs.iapmo.org/2018/UPC/mobile/index.html#p=144")
    
}

struct SourceLink {
    var name: String
    var link: String
    init(name: String,
         link: String) {
        self.name = name
        self.link = link
    }
    
}

struct DefaultKeys {
    //MARK: TODO - change version number in review key when updating
    static let kPromptForReviewCountDefaultKey = "CodeSnapMainLinePromptForReviewVersion2.8"
    static let dataSet = "MainLineDataSetForCoreDataKey"
    
}

struct ResultInfo {
    static let data = [
        "This is the minimum water meter, main line & branch line size allowed based on the total fixture units.",
        "Total fixture units are based on the gallons per minute of the chosen fixtures.",
        "The actual P.S.I. is determined by positive or negative change in elevation from the supply source to the highest water supply outlet.  0.5 P.S.I. is added or subtracted",
        "Fixture units are based on fixtures that comply with national standards & have a UPC stamp."
    ]
    
}

struct CellIds {
    static let measurments = "MeasurmentCellID"
    static let fixtures = "FixtureTableViewCellID"
    static let result = "ResultTableViewCellID"
    
}



struct ErrorHandler {
    static func coreDataDidRevieveError() {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            AlertUtility.alert(title: "Error",
                               message: "There was a problem saving data.  If this persists please contact the developer.",
                               view: vc)
        }
    }
    
}

struct ResultHeaderHelper {
    static func setText(section: Int) -> String {
        switch section {
        case 0:
            return "Minimum Pipe Size"
        case 1:
            return "Total Fixture Units"
        case 2:
            return "Measurements"
        case 3:
            return "Fixtures"
        default:
            return ""
        }
    }
    
}

struct ResultData {
    var sizes: [String]
    var totalUnits: Double
    var measurments: [String]
    var chosenFixtures: [Fixture]
    let count = 4
    init() {
        let measurmentModel = Array<Measurements>.measurmentsSorted()
        chosenFixtures = ResultHelper.chosenFixtures()
        let actualPSI = ResultHelper.actualPsi(psi: measurmentModel[0].value,
                                               height: measurmentModel[1].value)
        sizes = ResultHelper.meterSize(answer: AnswerUtility.checkAnswer(psi: actualPSI,
                                                                         distance: measurmentModel[2].value,
                                                                         fixtureUnits: ResultHelper.getTotalFixtureUnits(chosenFixtures: chosenFixtures)))
        measurments = ResultHelper.measurmentArray(actualPsi: actualPSI,
                                                   psi: measurmentModel[0].value,
                                                   height: measurmentModel[1].value,
                                                   distance: measurmentModel[2].value)
        totalUnits = ResultHelper.getTotalFixtureUnits(chosenFixtures: chosenFixtures)
    }
    
}

struct FixtureData {
    //Gets the total count of the chosen fixtures
    static func totalCount(fixtures: [Fixture]) -> Int16{
        var totalArray = [Int16]()
        for item in fixtures {
            if item.fixtureCount != 0 {
                totalArray.append(item.fixtureCount)
            }
        }
        var total:Int16 = 0
        for item in totalArray {
            total += item
        }
        return total
    }
    
}
