//
//  TaskCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//

import SwiftUI

struct TaskCardView: View {
    let task: VTask
    
    var body: some View {
        HStack(spacing: 10) {
            // Contenido a la izquierda
            VStack(alignment: .leading, spacing: 20) {
                
                VStack (alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text(task.description ?? "No description")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                
                HStack(spacing: 6) {
                    
                    StatusBadge(text: task.importance.rawValue, color: importanceColor)
                    
                    StatusBadge(text: task.status.rawValue, color: statusColor)
                    
                    
                    Text(Date().formatted(.dateTime.day().month()))
                        .font(.caption2)
                        .foregroundStyle(.black.opacity(0.7))
                        .padding(.leading, 10)
                    
                    Image(systemName: "arrow.right")
                        .font(.caption)
                    
                    Text(task.deadLine.formatted(.dateTime.day().month()))
                        .font(.caption.bold())
                        .foregroundStyle(.black.opacity(0.7))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 2)
        )
    }
    
    private var statusColor: Color {
        if task.status == .done {
            return .green
        } else if task.status == .inProgress {
            return .orange
        } else {
            return .gray
        }
    }
    private var importanceColor: Color {
        if task.importance == .high {
            return .red
        } else if task.importance == .medium {
            return .yellow
        } else {
            return .green
        }
    }
}


#Preview {
    TaskCardView(task: (
        .init(
            id: UUID(),
        title: "Wash the car",
        description: "Go to “Carwash” in nort, choose the big pay and also the inside",
        deadLine: .distantFuture,
        importance: .low,
        status: .inProgress
        )
    )
    )
}
