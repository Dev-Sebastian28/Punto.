//
//  CargoListViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 11/05/26.
//
import Foundation

@Observable
final class CargoListViewModel {
    // MARK: init:
    init(userId: UUID) {
        self.service = CargoService(userId: userId)
    }

    // MARK: Dependencies:
    let service: CargoService
    
    // MARK: State:
    var cargos: [Cargo] = []
    var isLoading: Bool = false

     // MARK: Serivice Fuctions:
    func fetchCargos() async {
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            
            self.cargos = try await service.getRequest.fetchItems(model: Cargo.self, itemId: nil, columnName: "")
        } catch {
            print(error)
        }
    }
}
