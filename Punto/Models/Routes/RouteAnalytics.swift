//
//  RouteAnalytics.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation

class RouteAnalytics: Codable {
    var routes: [RouteModel]
    
    func calculateAverageTravelDistance() -> Double {
        guard !routes.isEmpty || routes.count < 2 else { return 0 }
       let totalDistance: Double = routes.reduce(0) { partialResult, RouteModel in
            partialResult + RouteModel.distance
        }
        
        return totalDistance / Double(routes.count)
        
    }
}

let mydRoute = RouteModel(startPointDirection: "", endPointDirection: "", distance: 0, duration: 0)
