//
//  VehicleProtocolCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct VehicleProtocolCardView: View {
    var vehicleProtocol: VehicleProtocol
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                // Header
                VStack(alignment: .leading, spacing: 6) {
                    Text(vehicleProtocol.name)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.yellow)
                    HStack(spacing: 50) {
                        Text("Every Week")
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.gray.opacity(0.15))
                            .foregroundStyle(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                        Text(vehicleProtocol.importance.rawValue)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }.font(.caption2)
                }

                // Separator
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.4))

                // Tasks
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(vehicleProtocol.tasks, id: \.id) { task in
                        VStack(alignment: .leading, spacing: 0) {
                            Text("- \(task.task)")
                                .bold()
                            if let description = task.description {
                                Text(description)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .font(.footnote)
                    }
                }


            }
            .padding(10)
            .frame(width: 180, height: 240, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5))
            )

            // Optional description
            if let description = vehicleProtocol.description {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.4))
                VStack(alignment: .leading, spacing: 4) {
                    Text("Description:")
                        .font(.subheadline.weight(.semibold))
                    Text(description)
                        .foregroundStyle(.gray)
                        .font(.footnote)
                }
            }

        }
    }
}


#Preview {
    let sample = VehicleProtocol(
        id: UUID(),
        name: "Revisión  PESV",
        description: "Inspección técnica obligatoria según normatividad colombiana antes de iniciar ruta.",
        tasks: [
            ProtocolTask(id: UUID(), task: "Nivel de aceite y refrigerante", description: "Verificar que los fluidos estén en los niveles óptimos.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), task: "Estado de llantas (Labrado)", description: "Revisar que el desgaste no supere los límites legales.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), task: "Kit de carretera completo", description: "Extintor vigente, tacos, gata y señales reflectivas.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), task: "Luces y direccionales", description: "Comprobar funcionamiento de luces altas, bajas y frenado.", isCompleted: false, isActive: true)
        ],
        importance: .high,
        time: .startingWork
    )

    let items = Array(repeating: sample, count: 4)

    ScrollView {
        let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(0..<items.count, id: \.self) { i in
                VehicleProtocolCardView(vehicleProtocol: items[i])
            }
        }
        .padding(12)
    }
}
