//
//  DriverViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/04/26.
//

import Foundation

@Observable
final class AddDriverViewModel {
    private(set) var user: User
    var vehicles: [any Vehicle] {
        user.vehicles
    }

    func addDriver(_ driver: DriverInvitation, index: Int) {
        guard vehicles.indices.contains(index) else { return }
        print(user.vehicles[index].drivers)
        user.vehicles[index].drivers.append(driver)
        print(user.vehicles[index].drivers)

        
    }
    
    init(user: User) {
        self.user = user
    }
}
