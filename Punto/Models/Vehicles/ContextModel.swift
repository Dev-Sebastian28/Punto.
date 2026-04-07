//
//  ContextModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/04/26.
//

import Foundation

enum LoadContext: String, CaseIterable {
    case light = "Light"
    case medium = "Medium"
    case heavy = "Heavy"

    var factor: Double {
        switch self {
        case .light:
            1.0
        case .medium:
            0.8
        case .heavy:
            0.7
        }
    }
}

enum TemperatureContext: String {
    case temperateClimate = "Temperate climate"
    case moderateHeat = "Moderate heat"
    case extremeHeatCoast = "Extreme heat (coast)"
    
    var factor: Double {
        switch self {
        case .temperateClimate:
            1.0
        case .moderateHeat:
            0.8
        case .extremeHeatCoast:
            0.7
        }
    }
}

enum DustyContext: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var factor: Double {
        switch self {
        case .low:
            1.0
        case .medium:
            0.8
        case .high:
            0.7
        }
    }
}

enum TrafficContext: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var factor: Double {
        switch self {
        case .low:
            1.0
        case .medium:
            0.8
        case .high:
            0.7
        }
    }
}

enum TerrainContext: String {
    case flat = "Flat"
    case hilly = "Hilly"
    case mountainous = "Mountaineous"
    
    var factor: Double {
        switch self {
        case .flat:
            1.0
        case .hilly:
            0.8
        case .mountainous:
            0.7
        }
    }
}
