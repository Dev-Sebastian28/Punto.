//
//  ViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation

@Observable
final class TaskListViewModel {
    private let appState: AppState
    private let state: TaskState

    var selectedVehicle: Int {
        state.selectedVehicleIndex
    }
    
    private var vehicles: [Vehicle] { appState.user.vehicles }
    var hasVehicles: Bool { !vehicles.isEmpty }
    
    var selectedtotalTasks: String {
        appState.user.vehicles[selectedVehicle].tasks.count.description
    }
    
    var Tasks: [VTask] {
        appState.user.vehicles[selectedVehicle].tasks
    }
    
    var selectedVehicleBrandModel: String {
        appState.user.vehicles[selectedVehicle].vehicleInformation.model + " " + appState.user.vehicles[selectedVehicle].vehicleInformation.brand
    }
    var selectedVehiclePlate: String {
        appState.user.vehicles[selectedVehicle].vehicleInformation.plate
    }
    
    init(appState: AppState, state: TaskState) {
        self.appState = appState
        self.state = state
    }
}

@Observable
final class TaskViewModel {
    private var appState: AppState
    private let state: TaskState

    var selectedVehicle: Int {
        state.selectedVehicleIndex
    }
    
    
    func addTask(_ task: VTask) {
        appState.user.vehicles[selectedVehicle].tasks.append(task)
    }
    
    func updateTask(_ updatedTask: VTask, at index: Int) {
        appState.user.vehicles[selectedVehicle].tasks.updateTask(updatedTask, at: index)
    }
    
    func deleteTask(at index: Int) {
        appState.user.vehicles[selectedVehicle].tasks.removeTask(at: index)
    }
    
    init(appState: AppState, state: TaskState) {
        self.appState = appState
        self.state = state
    }
}
