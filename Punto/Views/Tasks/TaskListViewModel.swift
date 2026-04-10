//
//  ViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation

@Observable
final class TaskListViewModel { //When do you use final, open, public, private, etc
    var userModel: User
    var vehicles: [Vehicle] {
        userModel.vehicles
    }
    
    var selectedVehicle: Int

    var totalTasks: Int {
        userModel.vehicles[self.selectedVehicle].tasks.count
    }
    
    var totalTodoTasks: Int {
        userModel.vehicles[self.selectedVehicle].tasks.reduce(0) { partialResult, task in
            task.status == .pending ? partialResult + 1 : partialResult
        }
    }
    
    var totalDoneTasks: Int {
        userModel.vehicles[self.selectedVehicle].tasks.reduce(0) { partialResult, task in
            task.status == .done ? partialResult + 1 : partialResult
        }
    }

    var selectedVehicleModel: String {
        userModel.vehicles[self.selectedVehicle].vehicleInformation.model
    }
    var selectedVehicleBrand: String {
        userModel.vehicles[self.selectedVehicle].vehicleInformation.brand

    }
    var selectedVehiclePlate: String {
        userModel.vehicles[self.selectedVehicle].vehicleInformation.plate

    }


    func updateSelectedVehicle(index: Int) {
        selectedVehicle = index
    }
    
    init(userModel: User, selectedVehicle: Int) {
        self.userModel = userModel
        self.selectedVehicle = selectedVehicle
        randomDummyData()
        randomDummyData()
        randomDummyData()
    }
}

extension TaskListViewModel {
    func randomDummyData() {
        guard !userModel.vehicles.isEmpty else { return }
        
        let randomIndex = Int.random(in: 0..<userModel.vehicles.count)
        
        userModel.vehicles[randomIndex].tasks.dummyData()
    }
}
