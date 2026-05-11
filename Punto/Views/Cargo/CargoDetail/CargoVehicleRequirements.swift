//
//  CargoVehicleRequirements.swift
//  Punto
//
//  Created by Sebastian Garcia on 6/05/26.
//
import SwiftUI


// MARK: - Vehicle Requirements
struct CargoVehicleRequirements: View {
    var body: some View {
        VStack(alignment: .leading) {
            CardHeader(icon: "truck.box.fill", title: "Vehicle Requirements", color: .green)

            InfoRow(label: "Required Type", value: "Tractomula / Furgón")
            InfoRow(label: "Required Vehicle Trailer", value: "10m / 12m / 15m")

            Divider()

            DescriptionBlock(
                icon: "text.alignleft",
                text: "El vehículo debe estar habilitado para carga refrigerada y cumplir con normativas de transporte."
            )
        }.genericRoundedBackgroundShadow(color: .gray)
    }
}

#Preview {
    CargoVehicleRequirements()
}
