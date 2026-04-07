//
//  MaintenanceFormView.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/04/26.
//

import SwiftUI


struct MaintenanceFormView: View {
    
    @State private var selection: LoadContext = .light
    
    var body: some View {
        VStack(spacing: 20) {
            LabeledSegmentedPicker(title: "Type of load", selection: $selection) {
                Text("Light")
                Text("Medium")
                Text("Heavy")
            }
            
            LabeledSegmentedPicker(title: "Temperature Context", selection: $selection) {
                Text("Temperate climate")
                Text("Moderate heat")
                Text("Extreme heat (coast)")
            }
            
            
            LabeledSegmentedPicker(title: "Dusty Context", selection: $selection) {
                Text("Low")
                Text("Medium")
                Text("High")
            }
            
            LabeledSegmentedPicker(title: "Trafic / Conduction", selection: $selection) {
                Text("Highway")
                Text("Mixed")
                Text("Heavy City")
            }
            
            LabeledSegmentedPicker(title: "Type of terrain", selection: $selection) {
                Text("Flat")
                Text("Mountain")
                Text("Mixed")
            }
        }
    }
}

#Preview {
    MaintenanceFormView()
}

//Aceite de motor
//Filtro de aceite
//Filtro de aire
//Filtro de cabina
//Líquido de frenos
//Refrigerante
//Aceite de transmisión
//Aceite de diferencial
//
//👉 Estos son los más importantes para tu algoritmo
//👉 Aquí aplicas directamente tu modelo de factores
//
//⚙️ 🧩 2. TIPO 2 — DESGASTE (NO fijo)
//
//Estos NO tienen intervalo exacto
//👉 Se cambian cuando se desgastan
//
//Ejemplos:
//Pastillas de freno
//Discos de freno
//Embrague
//Llantas
//Amortiguadores
