//
//  FleetVehicleCardViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//
import Foundation

@Observable
final class FleetVehicleCardViewModel {
    var vehicle: any Vehicle
    private var vehicleInfo: VehicleInformation {
        vehicle.vehicleInformation
    }
    
    // Card Vehicle Information
    var isWorking: Bool {
    vehicle.isActive
}
    var vehicleImage: String {
        vehicleInfo.imageUrl ?? ""
    }
    var brandModel: String {
        vehicleInfo.brand.localizedCapitalized + " " + vehicleInfo.model.localizedCapitalized
    }
    var licensePlate: String {
        vehicleInfo.plate
    }
    
    // Drivers Information
    var hasDrivers: Bool {
        !vehicle.drivers.isEmpty
    }
    var drivers: [DriverInvitation] {
        vehicle.drivers
    }
    
    var currentDriver: DriverInvitation? {
        guard hasDrivers else {
            return nil
        }
        return vehicle.drivers.first!
    }
    var currentDriverInitials: String {
        guard hasDrivers else {
            return ""
        }
        let parts = vehicle.drivers.first!.name.split(separator: " ")
        let prefix = parts.prefix(2).compactMap { $0.first }
        
        return prefix.isEmpty ? "DR" : String(prefix)
    }
    
    
    var pendingTask: Int {
        vehicle.tasks.filter { $0.status == .pending }.count
    }
    var pendingProtocols: Int {
        // Check Protocols model (add Status)
        vehicle.protocols.count
    }
    var maintenances: Int {
        var count: Int = 0
        for maintenance in vehicle.maintenance {
            let state = MaintenanceAnaliser(comp: maintenance).calculateState()
            if state == .overdue || state == .warning {
                count += 1
            }
        }
        
        return count
    }
    var newExpeneses: Int {
        vehicle.expenses.count
    }
    
    
    init(vehicle: any Vehicle) {
        self.vehicle = vehicle
    }
}
