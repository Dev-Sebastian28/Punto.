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
                  MonthlyExpensesView()
                }
                
                Tab("Expenses", systemImage: "banknote.fill") {
                   MonthlyExpensesView()
                }
                
                Tab("Fleet", systemImage: "truck.box.fill") {
                    FleetView(user: user)
                }

                Tab("Driver", systemImage: "person.crop.circle.fill") {
                    DriverControlPanel()
                }
            }
        
    }
}


#Preview {
    MainTabView(user: .mock)
        .environment(NavigationRouter())
}
