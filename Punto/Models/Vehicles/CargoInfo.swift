//
//  cargoInfoModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//

enum TrailerType: String, CaseIterable {
    case dryVan53 = "53' Dry Van"
    case dryVan48 = "48' Dry Van"
    case reefer = "Refrigerated (Reefer)"
    case flatbed = "Flatbed"
    case lowboy = "Lowboy / Double Drop"
    case stepDeck = "Step Deck"
    case dumpTrailer = "End Dump"
    case tanker = "Tanker"
    case chassis = "Intermodal Chassis"
    case livestock = "Livestock Trailer"
    
    var description: String {
           switch self {
           case .dryVan53, .dryVan48: return "Standard enclosed trailer for general cargo."
           case .reefer: return "Temperature-controlled trailer for perishables."
           case .flatbed: return "Open trailer for oversized or side-loaded cargo."
           case .lowboy: return "Ultra-low deck for hauling heavy machinery and tall equipment."
           case .stepDeck: return "Trailer with a lowered deck to accommodate taller loads."
           case .dumpTrailer: return "Used for hauling loose bulk materials like sand or gravel."
           case .tanker: return "Designed for hauling liquids or gases."
           case .chassis: return "Framework for securing ocean shipping containers."
           case .livestock: return "Ventilated trailer for transporting animals."
           }
       }
}

struct CargoInfo {
    var trailerType: TrailerType
    var numberOfWheels: Int
}

// mirar los mantenimoentos 
