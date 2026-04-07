//
//  TaskCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//

import SwiftUI

struct TaskCardView: View {
    @State var task: Task

    var body: some View {
        HStack(spacing: 16) {
            // Contenido a la izquierda
            VStack(alignment: .leading, spacing: 0) {
                // Title and Description
                VStack (alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(task.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }.padding(.bottom, 10)

                HStack(spacing: 8) {
                    StatusBadge(text: task.importance.rawValue, color: importanceColor)
                    StatusBadge(text: task.status.rawValue, color: statusColor)
                    
                    Spacer()
                    
                    Text(task.date.formatted(.dateTime.day().month()))
                        .font(.caption2)
                        .foregroundStyle(.black.opacity(0.7))
                    Image(systemName: "arrow.right")
                        .font(.caption)
                    Text(task.date.formatted(.dateTime.day().month()))
                        .font(.caption.bold())
                        .foregroundStyle(.black.opacity(0.7))
                }
                .padding(.top, 4)
            }.padding(.leading)

            // Área de imagen/icono lateral
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 90, height: 90)
                .padding(.trailing)

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 2)
        )
    }

    // Lógica de colores (encapsulada)
    private var statusColor: Color { if task.status == .done {
        return .green
            } else if task.status == .inProgress {
            return .orange
        } else {
            return .gray
        }
    }



    private var importanceColor: Color { if task.importance == .high{
        return .red
    } else if task.importance == .medium {
            return .yellow
        } else {
            return .green
        }
    }
}

// Subvista para las etiquetas (esto evita sobrecargar el body principal)
private struct StatusBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text.capitalized)
            .font(.system(size: 10, weight: .bold))
            .foregroundStyle(color)
            .padding(.horizontal, 5)
            .padding(.vertical, 6)
            .background(color.opacity(0.15))
            .clipShape(Capsule())
    }
}

#Preview {
    TaskCardView(task: (.init(
        title: "Wash the car",
        description: "Go to “Carwash” in nort, choose the big pay and also the inside",
        date: .distantFuture,
        importance: .low,
        status: .inProgress
    )))
}
