//
//  ViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation
import Observation

@Observable
final class TaskListViewModel {
    private let user: User
    var selectedVehicle: Int
    var vehicles: [Vehicle] { user.vehicles }
    
    var totalTasks: Int {
        user.vehicles[selectedVehicle].tasks.count
    }
   
    var selectedVehicleModel: String {
        user.vehicles[selectedVehicle].vehicleInformation.model
    }
    var selectedVehicleBrand: String {
        user.vehicles[selectedVehicle].vehicleInformation.brand
    }
    var selectedVehiclePlate: String {
        user.vehicles[selectedVehicle].vehicleInformation.plate
    }
    
    func addTask(_ task: VTask) {
        user.vehicles[selectedVehicle].tasks.append(task)
    }

    func updateTask(_ updatedTask: VTask) {
        guard let taskIndex = user.vehicles[selectedVehicle].tasks.firstIndex(where: { $0.id == updatedTask.id }) else {
            return
        }

        user.vehicles[selectedVehicle].tasks[taskIndex] = updatedTask
    }


    init(user: User, selectedVehicle: Int = 0) {
        self.user = user
        self.selectedVehicle = selectedVehicle
    }
}
