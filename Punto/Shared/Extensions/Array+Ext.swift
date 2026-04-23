//
//  Array+Ext.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/04/26.
//

import Foundation

extension Array where Element == VehicleProtocol {
    mutating func addProtocol(_ element: VehicleProtocol) {
        self.append(element)
    }
    
    mutating func removeProtocol(index: Int) {
        guard self.indices.contains(index) else { return }
        self.remove(at: index)
    }
    
    mutating func updateProtocol(index: Int, newValue: VehicleProtocol) {
        guard self.indices.contains(index) else { return }
        let oldId = self[index].id
        self[index] = newValue
        self[index].id = oldId
    }
}

extension Array where Element == VTask {
    
    
    
    mutating func removeTask(at index: Int) {
        guard self.indices.contains(index) else { return }
        self.remove(at: index)
    }
    
    mutating func updateTask(_ newValue: VTask, at index: Int) {
        guard self.indices.contains(index) else { return }

        let vehicleWithCorrectId = VTask(
            id: newValue.id,
            title: newValue.title,
            description: newValue.description,
            deadLine: newValue.deadLine,
            importance: newValue.importance,
            status: newValue.status,
            
        )
        
        self[index] = vehicleWithCorrectId
    }
}
