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
    var totalTodoTasks: Int {
        user.vehicles[selectedVehicle].tasks.filter { $0.status == .pending }.count
    }
    var totalDoneTasks: Int {
        user.vehicles[selectedVehicle].tasks.filter { $0.status == .done }.count
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

    func updateSelectedVehicle(index: Int) {
        selectedVehicle = index
    }

    init(user: User, selectedVehicle: Int = 0) {
        self.user = user
        self.selectedVehicle = selectedVehicle
    }
}
