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
    var mesage: String = ""
    
    init(user: User) {
        self.user = user
    }
    
    
    func sendInvitation(_ driver: DriverInvitation, forVehicle: Int) {
        guard vehicles.indices.contains(forVehicle) else { return }
        
        let invitationService = DriverInvitationService()
        // Message to show
        var message: String = ""
        
        Task {
            let invitation = Invitation(number: driver.phone, nombre: driver.name, vehicleInf: "f150")
            
            let index = user.vehicles[forVehicle].drivers.firstIndex(where: {$0.phone == driver.phone})
            
            let response = try await invitationService.sendInvitation(invitation)
            
            switch response {
            case "success":
                user.vehicles[forVehicle].drivers.append(driver)
                user.vehicles[forVehicle].drivers[index ?? 0].status = .accepted
            case "invalid credencials":
                message = "invalid credencials"
            case "denied":
                message = "denied invitation"
            case "pending":
                user.vehicles[forVehicle].drivers.append(driver)
                user.vehicles[forVehicle].drivers[index ?? 0].status = .pending
                
            default:
                message = "unknown error"
            }
            self.mesage = message
        }
    }
}

struct Invitation: Codable {
    var number: Int
    var nombre: String
    var vehicleInf: String
}



