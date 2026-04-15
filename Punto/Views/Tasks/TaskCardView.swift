//
//  TaskCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//

import SwiftUI

struct TaskCardView: View {
    let task: Task

    var body: some View {
        HStack(spacing: 16) {
            // Contenido a la izquierda
            VStack(alignment: .leading, spacing: 10) {
                
                VStack (alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(task.description ?? "No description")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                
                HStack(spacing: 2) {
                    
                    StatusBadge(text: task.importance.rawValue, color: importanceColor)
                    
                    StatusBadge(text: task.status.rawValue, color: statusColor)
                

                    Text(Date().formatted(.dateTime.day().month()))
                        .font(.caption2)
                        .foregroundStyle(.black.opacity(0.7))
                        .padding(.leading, 10)
                    
                    Image(systemName: "arrow.right")
                        .font(.caption)
                    
                    Text(task.date.formatted(.dateTime.day().month()))
                        .font(.caption.bold())
                        .foregroundStyle(.black.opacity(0.7))
                }
                
            }.padding(.leading)

            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 90, height: 90)
                .padding(.trailing)

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
private struct StatusBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text.capitalized)
            .font(.system(size: 10, weight: .bold))
            .foregroundStyle(color)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
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
    ))
    )
}
