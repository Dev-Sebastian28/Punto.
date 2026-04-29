//
//  MainTabView.swift
//  Punto
//
//  Created by OpenAI on 2026.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @Environment(NavigationRouter.self) var router
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
            TabView {
                Tab("Cargos", systemImage: "shippingbox.fill") {
                  CargoView()
                }
                
                Tab("Expenses", systemImage: "banknote.fill") {
                   MonthlyExpensesView()
                }
                
                Tab("Fleet", systemImage: "truck.box.fill") {
                    FleetView(user: user)
                }

                Tab("Account", systemImage: "person.crop.circle.fill") {
                    ProfileView(user: user)
                }
            }
    }
}


#Preview {
    MainTabView(user: .mock)
        .environment(NavigationRouter())
}
