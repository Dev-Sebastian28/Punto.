//
//  PuntoTests.swift
//  PuntoTests
//
//  Created by Sebastian Garcia on 15/02/26.
//

import Testing
import Foundation

@testable import Punto


struct MaintenanceTests {
    let maintenanceLogic = MaintenanceLogic(
        componet: .init(
            componentName: "Oil Filter",
            lastTimeMaintainedInformation: (Date(), 4000),
            rangeOfUsefulLife: 8000...12000,
            rangeDateOfUsefulLife: Date()...Date()),
        factors: 0.7,
        unitMeasurement: 10000)

    
    @Test func factorAnalysis() {
        try? #require (maintenanceLogic.factors >= 0.4 && maintenanceLogic.factors <= 1.0)
        let (low, up) = maintenanceLogic.calculateAnalysisWithFactors()
        try? #require(low < up)
        
        #expect(low == 5600)
        #expect(up == 8400)

    }
    
    @Test func testRemainingUsefulLife() {
        
        #expect(maintenanceLogic.calculateUnitTraveledRemainig() == 2000)
    }

}
