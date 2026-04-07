//
//  MainTabView.swift
//  Punto
//
//  Created by OpenAI on 2026.
//

import SwiftUI

struct MainTabView: View {
    @Environment(NavigationRouter.self) var router
    var body: some View {
            TabView {
                Tab("Fleet", systemImage: "truck.box.fill") {
                    FleetView()
                }

                Tab("Expenses", systemImage: "banknote.fill") {
                    ExpensesView()
                }

                Tab("Driver", systemImage: "person.crop.circle.fill") {
                    DriverControlPanel()
                }
            }
        
    }
}


#Preview {
    MainTabView()
        .environment(NavigationRouter())
}
