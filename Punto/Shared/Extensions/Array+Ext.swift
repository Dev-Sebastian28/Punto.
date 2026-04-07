//
//  Array+Ext.swift
//  Punto
//
//  Created by Sebastian Garcia on 25/02/26.
//

import Foundation

extension Array where Element == Vehicle {
    mutating func addVehicle(vehicle: Vehicle) {
        self.append(vehicle)
    }

    mutating func removeVehicle(at index: Int) {
        self.remove(at: index)
    }

    mutating func updateVehicle(at index: Int, with vehicle: Vehicle) {
        self[index] = vehicle
    }
}


extension Array where Element == Expense {
    mutating func addExpense(expense: Expense) {
        self.append(expense)
    }

    mutating func removeExpense(at index: Int) {
        self.remove(at: index)
    }
    
    mutating func updateExpense(at index: Int, with expense: Expense) {
        self[index] = expense
    }
}

extension Array where Element == Task {
    mutating func addTask(task: Task) {
        self.append(task)
    }
    
    mutating func removeTask(at index: Int) {
        self.remove(at: index)
    }
    
    mutating func updateTask(at index: Int, with task: Task) {
        self[index] = task
    }
}

extension Array where Element == VehicleProtocol {
    mutating func addProtocol(vehicleProtocol: VehicleProtocol) {
        self.append(vehicleProtocol)
    }
    
    mutating func removeProtocol(at index: Int) {
        self.remove(at: index)
    }
    
    mutating func updateProtocol(at index: Int, with vehicleProtocol: VehicleProtocol) {
        self[index] = vehicleProtocol
    }
}
