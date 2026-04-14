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
    case overdue = "Overdue"
}

struct MaintenanceAnaliser {
    let comp: VehiclePartWrapper
    var inf: (Date, Int) {
        let date = comp.lastMaintenanceDate
        let unity = comp.lastMaintenanceUnity
        return (date, unity)
        
    }
    var traveled: Int {
        comp.currentUnity - inf.1
    }
    
    func calculateRemaining() -> Int {
        RemainingUnityAnalyzer().perform(comp: comp, traveled: traveled)
    }
    
    func calculateState() -> MaintenanceState {
        StateAnalyzer().perform(comp: comp, traveled: traveled)
    }
    
    func calculatePorcentage() -> Int {
        PercentageCalculator().calculate(comp: comp, traveled: traveled)
    }
}

struct MaintenaceDataTransfer {
    func perform(comp: VehiclePartWrapper) -> MaintenanceCardData {
        let analizer = MaintenanceAnaliser(comp: comp)
        let comp = analizer.comp
        
        let image = comp.vehiclePart.systemImage
        let name = comp.vehiclePart.partName
        
        var description: String {
            if let min = comp.vehiclePart.kmMin, let max = comp.vehiclePart.kmMax {
                return "\(min) - \(max)"
            } else {
                return "\(comp.vehiclePart.kmFixed ?? 0)"
            }
        }
        let remaining = analizer.calculateRemaining()
        let state: MaintenanceState = analizer.calculateState()
        let porcentage = analizer.calculatePorcentage()
        
        return .init(image: image, name: name, state: state, usefulDescription: description, remaining: remaining.description, porcent: porcentage)
    }
}

private struct RemainingUnityAnalyzer {
    func perform(comp: VehiclePartWrapper, traveled: Int) -> Int {
        let max = comp.vehiclePart.kmMax ?? comp.vehiclePart.kmFixed ?? 0
        return Swift.max(0, max - traveled) // nunca negativo
    }
}

private struct StateAnalyzer {
    private static let warningThreshold = 0.20 // 20% antes del límite

    func perform(comp: VehiclePartWrapper, traveled: Int) -> MaintenanceState {
        if let min = comp.vehiclePart.kmMin,
           let max = comp.vehiclePart.kmMax {
            if traveled < min {
                return .good
            } else if traveled <= max {
                return .warning
            } else {
                return .overdue
            }
        } else {
            guard let kmFixed = comp.vehiclePart.kmFixed, kmFixed > 0 else {
                return .overdue
            }
            let fixed = Double(kmFixed)
            let ratio = Double(traveled) / fixed

            if ratio >= 1.0 {
                return .overdue
            } else if ratio >= (1.0 - Self.warningThreshold) { // >= 80% del límite
                return .warning
            } else {
                return .good // ← antes nunca llegaba aquí
            }
        }
    }
}

private struct PercentageCalculator {
    func calculate(comp: VehiclePartWrapper, traveled: Int) -> Int {
        let max: Int
        if let kmMax = comp.vehiclePart.kmMax {
            max = kmMax
        } else if let kmFixed = comp.vehiclePart.kmFixed, kmFixed > 0 {
            max = kmFixed
        } else {
            return 0 // guard contra división por cero
        }
        let pct = Int(Double(traveled) / Double(max) * 100)
        return Swift.max(0, Swift.min(100, pct))
    }
}

struct MaintenanceCardData {
    let image: String
    let name: String
    let state: MaintenanceState
    let usefulDescription: String
    let remaining: String
    let porcent: Int
}

    
    
    
    
    
    
