//
//  DataInit.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/13/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import Foundation

class DataInit {
    static func initCoreData() {
        //MARK: - Measurments
        let psi = Measurements(context: PersistanceService.context)
        let elevation = Measurements(context: PersistanceService.context)
        let distance = Measurements(context: PersistanceService.context)
        
        psi.information = "What is the pressure reading taken at the water supply source?"
        psi.placeHolderText = "Pounds per square inch"
        psi.requiresNegative = false
        psi.title = "P.S.I."
        psi.orderIndex = 0
        
        elevation.information = "What is the difference in evevation between the supply source & the highest water supply outlet?"
        elevation.placeHolderText = "Elevation in feet"
        elevation.requiresNegative = true
        elevation.title = "Elevation"
        elevation.orderIndex = 1
        
        distance.information = "What is the distance from the supply source to the most remote outlet?"
        distance.placeHolderText = "Length in feet"
        distance.requiresNegative = false
        distance.title = "Distance"
        distance.orderIndex = 2
        
        //MARK: - Fixtures
        let lav = Fixture(context: PersistanceService.context)
        lav.name = "Lavatory"
        lav.oneAllowed = false
        lav.units = 1.0
        lav.fixtureCount = 0
        lav.orderIndex = 0
        
        let bar = Fixture(context: PersistanceService.context)
        bar.name = "Bar Sink"
        bar.oneAllowed = false
        bar.units = 1.0
        bar.fixtureCount = 0
        bar.orderIndex = 1
        
        let ks = Fixture(context: PersistanceService.context)
        ks.name = "Kitchen Sink"
        ks.oneAllowed = false
        ks.units = 1.5
        ks.fixtureCount = 0
        ks.orderIndex = 2
        
        let dw = Fixture(context: PersistanceService.context)
        dw.name = "Dish Washer"
        dw.oneAllowed = false
        dw.units = 1.5
        dw.fixtureCount = 0
        dw.orderIndex = 3
        
        let lf = Fixture(context: PersistanceService.context)
        lf.name = "Laundry Faucet"
        lf.oneAllowed = false
        lf.units = 1.5
        lf.fixtureCount = 0
        lf.orderIndex = 4
        
        let ms = Fixture(context: PersistanceService.context)
        ms.name = "Mop Sink"
        ms.oneAllowed = false
        ms.units = 1.5
        ms.fixtureCount = 0
        ms.orderIndex = 5
        
        let ts = Fixture(context: PersistanceService.context)
        ts.name = "Tub Shower"
        ts.oneAllowed = false
        ts.units = 4.0
        ts.fixtureCount = 0
        ts.orderIndex = 6
        
        let sh = Fixture(context: PersistanceService.context)
        sh.name = "Shower Head"
        sh.oneAllowed = false
        sh.units = 2.0
        sh.fixtureCount = 0
        sh.orderIndex = 7
        
        let tv = Fixture(context: PersistanceService.context)
        tv.name = "Tub Valve 3/4\""
        tv.oneAllowed = false
        tv.units = 10.0
        tv.fixtureCount = 0
        tv.orderIndex = 8
        
        let cw = Fixture(context: PersistanceService.context)
        cw.name = "Clothes Washer"
        cw.oneAllowed = false
        cw.units = 4.0
        cw.fixtureCount = 0
        cw.orderIndex = 9
        
        let hb = Fixture(context: PersistanceService.context)
        hb.name = "Hose Bib"
        hb.oneAllowed = true
        hb.units = 2.5
        hb.fixtureCount = 0
        hb.orderIndex = 10
        hb.information = "When sizing an entire water system the first hose bib is counted as 2.5 fixture units.  Addtional hose bibs down stream are counted as 1.0 fixture unit.  If you were sizing a branch line with more than one hose bib, each hose bib would be considered 2.5 fixture units."
        
        let ahb = Fixture(context: PersistanceService.context)
        ahb.name = "Additional Hose Bib"
        ahb.oneAllowed = false
        ahb.units = 1.0
        ahb.fixtureCount = 0
        ahb.orderIndex = 11
        
        
        let wc = Fixture(context: PersistanceService.context)
        wc.name = "Water Closet"
        wc.oneAllowed = false
        wc.units = 2.5
        wc.fixtureCount = 0
        wc.orderIndex = 12
        
        let bid = Fixture(context: PersistanceService.context)
        bid.name = "Bidet"
        bid.oneAllowed = false
        bid.units = 1.0
        bid.fixtureCount = 0
        bid.orderIndex = 13
        
        
        DataInit.save()
        
    }
    static func save() {
        PersistanceService.saveContext(completion: {
            UserDefaults.standard.set(true,
                                      forKey: DefaultKeys.dataSet)
        }, errorCompletion: {
            UserDefaults.standard.set(false,
                                      forKey: DefaultKeys.dataSet)
            ErrorHandler.coreDataDidRevieveError()
        })
    }
}
