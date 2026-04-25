//
//  MainteenaceFilterView.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import SwiftUI

private enum Filters: CaseIterable {
    case overdue
    case warning
    case well
    case none
    
    var title: String {
        switch self {
        case .overdue: return "Overdue"
        case .warning: return "Warning"
        case .well: return "Well"
        case .none: return "None"
        }
    }
    
    var color: Color {
        switch self {
        case .overdue: return .red
        case .warning: return .yellow
        case .well: return .green
        case .none: return .clear
        }
    }
    
    var icon: Image {
        switch self {
        case .overdue: return Image(systemName: "exclamationmark.circle")
        case .warning: return Image(systemName: "exclamationmark.circle.fill")
        case .well: return Image(systemName: "checkmark.circle.fill")
        case .none: return Image(systemName: "circle.fill")
        }
    }
}


struct MaintenanceFilterView: View {
    @State private var isExpanded: Bool = false
    let millage: String
    let totalParts: String
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                HStack(spacing: 15) {
                    
                    // Millage
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Mileage")
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            Text(millage)
                                .font(.system(.subheadline, design: .rounded))
                                .bold()
                            
                            Text("km").font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                    
                    Divider()
                        .frame(height: 30)
                    
                    // Total Parts
                    HStack(spacing: 4) {
                        Image(systemName: "wrench.and.screwdriver.fill")
                        Text(totalParts)
                            .bold()
                    }
                    .foregroundStyle(.primary)
                    .font(.default)
                    
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color.white.opacity(0.65))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
                
                // Filter Button
                Button {
                    isExpanded.toggle()
                }
                label: {
                    HStack(spacing: 6) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        Text("Filters")
                            .font(.subheadline.bold())
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(.white)
                    .foregroundStyle(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
            .padding(6)
            .background(Color.blue.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        ScrollView {
            HStack {
                ForEach(Filters.allCases, id: \.self) { filer in
                    FilterButton(title: filer.title, isSelected: true, color: .brandAmber) {
                        
                    }
                }
            }
        }
    }
}

private struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    var body: some View {
        Text("Filter")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    MaintenanceFilterView(
        millage: "10000",
        totalParts: "0"
    )
}
