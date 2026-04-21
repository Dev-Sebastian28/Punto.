//
//  ExpenseFilterView.swift
//  Punto
//
//  Created by Sebastian Garcia on 12/03/26.
//

import SwiftUI

struct ExpenseFilterView: View {
    @Binding var isPresented: Bool
    @Binding var strategy: ExpenseStrategy
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.25), lineWidth: 0.8)
                        .blendMode(.overlay)
                ).shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
            
            VStack(spacing: 12) {
                HStack(spacing: 10) {
                    FilterChip(
                        title: "Profit",
                        systemImage: "arrow.up.right",
                        tint: .green
                    ) {
                        strategy = FilterIncomes()
                        
                        isPresented.toggle()
                    }
                    
                    FilterChip(
                        title: "Latest"
                        , systemImage: "clock.arrow.circlepath",
                        tint: .green
                    ) {
                        strategy = SortByAmount(descending: false)
                        isPresented.toggle()
                    }
                    
                    FilterChip(
                        title: "Ascending",
                        systemImage: "arrow.up",
                        tint: .green
                    ) {
                        strategy = SortByAmount(descending: true)
                        isPresented.toggle()
                    }
                    
                }
                
                HStack(spacing: 10) {
                    
                    FilterChip(
                        title: "Losses",
                        systemImage: "arrow.down.right",
                        tint: .red) {
                            
                            strategy = LossesFilter()
                            isPresented.toggle()
                        }
                    
                    FilterChip(
                        title: "Oldest",
                        systemImage: "clock",
                        tint: .red
                    ) {
                        strategy = SortByDate(latestFirst: true)
                        isPresented.toggle()
                    }
                    
                    FilterChip(
                        title: "Descending",
                        systemImage: "arrow.down",
                        tint: .red
                    ) {
                        strategy = SortByAmount(descending: false)
                        isPresented.toggle()
                    }
                    
                }
                Button {
                    strategy = DefaultStrategy()
                    isPresented.toggle()
                    
                }
                label: {
                    
                    Text("Clear Filters")
                    
                }.buttonStyle(.glassProminent)
                
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
        }
        .frame(height: 140)
        .padding(5)
    }
}

private struct FilterChip: View {
    var title: String
    var systemImage: String
    var tint: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                HStack(spacing: 8) {
                    Image(systemName: systemImage)
                        .font(.subheadline.weight(.semibold))
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                }
                .foregroundStyle(tint)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: tint.opacity(0.18), radius: 6, x: 0, y: 3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(tint.opacity(0.25), lineWidth: 1)
                )
                .frame(width: 110, height: 44)
            }
            .buttonStyle(.plain)
        }
        
    }
}

#Preview {
    ExpenseFilterView(isPresented: .constant(true), strategy: .constant(DefaultStrategy()))
}
