//
//  VehicleProtocolCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct ProtocolCardView: View {
    @State  var vehicleProtocol: VehicleProtocol
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Image(systemName: "list.dash")
                    Text(vehicleProtocol.name)
                    
                }
                .foregroundStyle(.yellow)
                .font(.title2.bold())
                
                HStack {
                    
                    HStack {
                        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                        Text(vehicleProtocol.time.rawValue)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.15))
                    .foregroundStyle(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    Spacer()
                    
                    importanceBagge(importance: vehicleProtocol.importance)
                }
            }
            
            Separator()
            
            VStack(alignment: .leading, spacing: 6) {
                ForEach(vehicleProtocol.tasks, id: \.id) { task in
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 5, height: 10)
                                .foregroundStyle(.yellow)
                            Text("\(task.taskName)").bold()
                        }
                        
                        if let description = task.description {
                            Text(description)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.secondary.opacity(0.5), lineWidth: 2)
        )
        
        
    }
    
    @ViewBuilder
    private func importanceBagge(importance: ProtocolImportance) -> some View {
        let color: Color = switch importance {
        case .high:
                .red
        case .medium:
                .orange
        default:
                .green
        }
        
        Text(vehicleProtocol.importance.rawValue)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(color.opacity(0.85))
            .foregroundStyle(.gray)
            .clipShape(.capsule)
    }
}


#Preview {
    ProtocolCardView(vehicleProtocol: .init(
        id: UUID(),
        name: "Revisión  PESV",
        description: "Inspección técnica obligatoria según normatividad colombiana antes de iniciar ruta.",
        tasks: [
            ProtocolTask(id: UUID(), taskName: "Nivel de aceite y refrigerante", description: "Verificar que los fluidos estén en los niveles óptimos.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Estado de llantas (Labrado)", description: "Revisar que el desgaste no supere los límites legales.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Kit de carretera completo", description: "Extintor vigente, tacos, gata y señales reflectivas.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Luces y direccionales", description: "Comprobar funcionamiento de luces altas, bajas y frenado.", isCompleted: false, isActive: true)
        ],
        importance: .high,
        time: .startingWork
    ))
}
