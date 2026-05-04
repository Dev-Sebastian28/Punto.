//
//  ViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation

@Observable
final class TaskListViewModel {
    // MARK: - init:
    init(appState: AppState, state: TaskState, service: TaskRepositoryProtocol) {
        self.appState = appState
        self.indexState = state
        self.repository = service
    }
    
    // MARK: - Dependencies:
    private let appState: AppState
    private let indexState: TaskState
    private let repository: TaskRepositoryProtocol

    var selectedVehicle: Int {
        indexState.selectedVehicleIndex
    }
    
    // MARK: - Computed Properties:
    private var vehicles: [Vehicle] { appState.user.vehicles }
    var hasVehicles: Bool { !vehicles.isEmpty }


    // MARK: - State:
    var isLoading: Bool = false
    var message: String?
    var selectedtotalTasks: String {
        appState.user.vehicles[selectedVehicle].tasks.count.description
    }
    var Tasks: [VTask] = []
    var selectedVehicleBrandModel: String {
        appState.user.vehicles[selectedVehicle].vehicleInformation.model + " " + appState.user.vehicles[selectedVehicle].vehicleInformation.brand
    }
    var selectedVehiclePlate: String {
        appState.user.vehicles[selectedVehicle].vehicleInformation.plate
    }

    // MARK: - Respository Accions:
    func updateTasks() async {
        isLoading  = true
        let result = try? await repository.fetchAll()
        switch result {
        case .success(let success):
            self.Tasks = success

        case .failure(let failure):
            self.message = failure.localizedDescription
        case .none:
            self.message = "unknown error"

        }
        isLoading = false
    }
    
    
}

@Observable
final class TaskViewModel {
    
    // MARK: - init:
    init(appState: AppState, state: TaskState, service: TaskRepositoryProtocol = MockTaskRepository()) {
        self.appState = appState
        self.indexState = state
        self.repository = service
    }
    
    // MARK: - Dependencies:
    private var appState: AppState
    private let indexState: TaskState
    private let repository: TaskRepositoryProtocol

    var selectedVehicle: Int {
        indexState.selectedVehicleIndex
    }
    
    // MARK: - State:
    var message: String?
    var isLoading: Bool = false
    
    
    // MARK: - Respository Accions:

    func addTask(_ task: VTask) async {
        isLoading  = true
        let result = try? await repository.save(task: task)
        switch result {
        case .success( _):
            appState.user.vehicles[selectedVehicle].tasks.append(task)

        case .failure(let failure):
            self.message = failure.localizedDescription
        case .none:
            self.message = "unknown error"

        }
        isLoading = false
    }
    
    func deleteTask(task: VTask) async {
        isLoading  = true
        let result = try? await repository.delete(task: task)
        switch result {
        case .success(_):
            appState.user.vehicles[selectedVehicle].tasks.removeAll(where: { $0.id == task.id })

        case .failure(let failure):
            self.message = failure.localizedDescription
        case .none:
            self.message = "unknown error"

        }
        isLoading = false
    }
    
    
    func updateTask(_ updatedTask: VTask, at index: Int) {
        appState.user.vehicles[selectedVehicle].tasks.updateTask(updatedTask, at: index)
    }

}
