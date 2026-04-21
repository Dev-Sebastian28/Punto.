//
//  CarouselViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 14/04/26.
//
import Foundation

@Observable
class CarouselViewModel {
    private var user: User
    var vehicles: [Vehicle] { user.vehicles }
    var isCarousellHide: Bool    
    func summaries(for vehicle: any Vehicle, algorithm: CarouselStrategy) -> [QuickSummary] {
           algorithm.perform(vehicle: vehicle)
       }

    init(user: User) {
        self.user = user
        self.isCarousellHide = false
    }
}
