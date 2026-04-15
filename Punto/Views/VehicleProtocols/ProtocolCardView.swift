//
//  VehicleProtocolCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct ProtocolCardView: View {
    let protocolM: VehicleProtocol
    @State private var isHide: Bool = false
    
    private var style: Color {
        switch protocolM.importance {
        case .low:
                .green
        case .medium:
                .yellow
        case .high:
                .red
        }
    }
    private var cardFill: LinearGradient {
        LinearGradient(
            colors: [
                Color(.systemBackground),
                style.opacity(0.08),
                style.opacity(0.18)
                
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            header
            
            if !isHide {
                content
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(cardFill)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(style.opacity(0.45), lineWidth: 1.5)
        )
    }
    
    private var header: some View {
        VStack(spacing: 14) {
            
            
            HStack(spacing: 10) {
                // Icon Image
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(style.opacity(0.14))
                        .frame(width: 54, height: 54)
                    
                    Image(systemName: "checkmark.shield.fill")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(style)
                }
                
                // Title and Description and button
                VStack(alignment: .leading, spacing: 5) {
                    
                    HStack {
                        Text(protocolM.name)
                            .font(.title3.bold())
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        
                        Button {
                            withAnimation(.linear) {
                                isHide.toggle()
                            }
                        } label: {
                            Label(isHide ? "Show" : "Hide", systemImage: isHide ? "chevron.up" : "chevron.down")
                                .foregroundStyle(style).bold()
                                .padding(8)
                                .background(
                                    Color.white                               .clipShape(.circle)
                                )
                        }.animation(.spring, value: isHide)
                    }
                    
                    if let description = protocolM.description, !description.isEmpty {
                        Text(description)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            HStack {
                protocolTimeBadge
                
                Spacer()
                
                importanceBadge
            }
        }
    }
    private var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("Checklist", systemImage: "checklist")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
                Divider().frame(height: 20)
                Spacer()
                Text("Total: \(protocolM.tasks.count)")
                    .font(.footnote.weight(.semibold))
            }
            
            ForEach(Array(protocolM.tasks), id: \.id) { task in
                subTask(name: task.taskName, description: task.description)
            }
        }
    }
    private func subTask(name: String, description: String?) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "circle.fill")
                    .font(.system(size: 8))
                    .foregroundStyle(style)
                    .padding(.top, 6)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                    
                    if let description = description {
                        Text(description)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Spacer(minLength: 0)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.white)
        )
    }
    
    private var protocolTimeBadge: some View {
        HStack(spacing: 6) {
            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
            Text(protocolM.time.rawValue)
        }
        .font(.footnote.weight(.semibold))
        .foregroundStyle(style)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(style.opacity(0.12))
        .clipShape(Capsule())
    }
    private var importanceBadge: some View {
        Text(protocolM.importance.rawValue)
            .font(.subheadline.bold())
            .foregroundStyle(.white)
            .padding(.horizontal, 18)
            .padding(.vertical, 6)
            .background(style)
            .clipShape(.capsule)
    }
}


#Preview {
    ProtocolCardView(protocolM: .init(
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
