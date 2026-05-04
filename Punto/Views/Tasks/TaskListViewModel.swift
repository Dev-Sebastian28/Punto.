//
//  ViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation

@Observable
final class TaskListViewModel {
    
    // MARK: - Dependencies:
    private let appState: AppState
    private let indexState: TaskState

    var selectedVehicle: Int {
        indexState.selectedVehicleIndex
    }
    
    private var vehicles: [Vehicle] { appState.user.vehicles }
    var hasVehicles: Bool { !vehicles.isEmpty }
    
    // MARK: - State:
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
        self.indexState = state
    }
}

@Observable
final class TaskViewModel {
    
    // MARK: - Dependencies:
    private var appState: AppState
    private let indexState: TaskState
    private let respository: TaskRepository

    var selectedVehicle: Int {
        indexState.selectedVehicleIndex
    }
    
    // MARK: - Dependencies:
    var message: String?
    
    
    func addTask(_ task: VTask) async {
        guard let result = try? await respository.save(task: task).get() else {
            return
        }
        print(result)
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
        self.indexState = state
        self.respository = TaskRepository(userId: appState.user.id)
    }
}
