//
//  MaintenanceModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/02/26.

// First Algorithm to try to get a realistic useful life of the component. (uses a form to know the external factors)

import Foundation

enum MaintenanceState: String {
    case good = "Good"
    case warning = "Warning"
    case critical = "Critical"
}

class MaintenanceLogic {
    
    let componet: MaintainableComponent
    let factors: Double
    let currentKm: Int
    
    func calculateAnalysisWithFactors() -> (Int, Int) {
        let low = Double(componet.rangeOfUsefulLife.lowerBound)  * factors
        let  up = Double(componet.rangeOfUsefulLife.upperBound) * factors
        
        return (Int(low), Int(up))
    }
    
    func analysisState() -> MaintenanceState {
        let traveled = currentKm - componet.lastTimeMaintainedInformation.1
        let (_, up) = calculateAnalysisWithFactors()
        
        if traveled < up {
            return .good
        } else if traveled >= up && traveled <= componet.rangeOfUsefulLife.lowerBound  {
            return .warning
        } else {
            return .critical
        }
        
    }
    
    func calculateUnitTraveledRemainig() -> Int {
        let traveled = currentKm - componet.lastTimeMaintainedInformation.1
        return componet.rangeOfUsefulLife.lowerBound - traveled
    }
    
    init(componet: MaintainableComponent, factors: Double, unitMeasurement: Int) {
        self.componet = componet
        self.factors = factors
        self.currentKm = unitMeasurement
    }
}









