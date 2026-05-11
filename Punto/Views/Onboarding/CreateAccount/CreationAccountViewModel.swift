//
//  CreationAccountViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 5/05/26.
//
import Foundation

@Observable
final class CreationAccountViewModel {
    private var user: User
    
    func createAccount(name: String, phone: Int, vehicles: Int) {
         
    }
    init(user: User) {
        self.user = user
    }
}
