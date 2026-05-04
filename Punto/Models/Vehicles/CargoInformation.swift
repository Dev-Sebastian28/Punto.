import Foundation

enum TrailerType: String, Codable, CaseIterable {
    case dryVan53  = "53' Dry Van"
    case dryVan48  = "48' Dry Van"
    case reefer    = "Refrigerated (Reefer)"
    case flatbed   = "Flatbed"
    case lowboy    = "Lowboy / Double Drop"
    case stepDeck  = "Step Deck"
    case dumpTrailer = "End Dump"
    case tanker    = "Tanker"
    case chassis   = "Intermodal Chassis"
    case livestock = "Livestock Trailer"

    var description: String {
        switch self {
        case .dryVan53, .dryVan48: return "Standard enclosed trailer for general cargo."
        case .reefer:               return "Temperature-controlled trailer for perishables."
        case .flatbed:              return "Open trailer for oversized or side-loaded cargo."
        case .lowboy:               return "Ultra-low deck for hauling heavy machinery and tall equipment."
        case .stepDeck:             return "Trailer with a lowered deck to accommodate taller loads."
        case .dumpTrailer:          return "Used for hauling loose bulk materials like sand or gravel."
        case .tanker:               return "Designed for hauling liquids or gases."
        case .chassis:              return "Framework for securing ocean shipping containers."
        case .livestock:            return "Ventilated trailer for transporting animals."
        }
    }

    var systemImage: String {
        switch self {
        case .dryVan53, .dryVan48: return "shippingbox.fill"
        case .reefer:               return "snowflake"
        case .flatbed:              return "rectangle.fill"
        case .lowboy, .stepDeck:    return "arrow.down.to.line"
        case .dumpTrailer:          return "trash.fill"
        case .tanker:               return "drop.fill"
        case .chassis:              return "square.stack.fill"
        case .livestock:            return "hare.fill"
        }
    }
}

struct CargoInformation: Codable {
    var trailerType: TrailerType
    var numberOfWheels: Int

    enum CodingKeys: String, CodingKey {
        case trailerType    = "trailer_type"
        case numberOfWheels = "number_of_wheels"
    }
}
