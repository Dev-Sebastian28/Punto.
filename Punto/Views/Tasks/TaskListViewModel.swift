//
//  ViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation

@Observable
final class TaskListViewModel {
    private let user: User
    private let state: TaskState

    var selectedVehicle: Int {
        state.selectedVehicleIndex
    }
    
    private var vehicles: [Vehicle] { user.vehicles }
    var hasVehicles: Bool { !vehicles.isEmpty }
    
    var selectedtotalTasks: String {
        user.vehicles[selectedVehicle].tasks.count.description
    }
    
    var Tasks: [VTask] {
        user.vehicles[selectedVehicle].tasks
    }
    
    var selectedVehicleBrandModel: String {
        user.vehicles[selectedVehicle].vehicleInformation.model + " " + user.vehicles[selectedVehicle].vehicleInformation.brand
    }
    var selectedVehiclePlate: String {
        user.vehicles[selectedVehicle].vehicleInformation.plate
    }
    init(user: User, state: TaskState) {
        self.user = user
        self.state = state
    }
}

@Observable
final class TaskViewModel {
    private var user: User
    private let state: TaskState

    var selectedVehicle: Int {
        state.selectedVehicleIndex
    }
    
    
    func addTask(_ task: VTask) {
        user.vehicles[selectedVehicle].tasks.append(task)
    }
    
    func updateTask(_ updatedTask: VTask, at index: Int) {
        user.vehicles[selectedVehicle].tasks.updateTask(updatedTask, at: index)
    }
    
    func deleteTask(at index: Int) {
        user.vehicles[selectedVehicle].tasks.removeTask(at: index)
    }
    
    init(user: User, state: TaskState) {
        self.user = user
        self.state = state
    }
}
