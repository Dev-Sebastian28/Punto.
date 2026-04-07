//
//  MainteenaceFilterView.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import SwiftUI

struct MaintenanceFilterView: View {
    var vm: MaintenanceViewModel
    var body: some View {
        // Filter View
        HStack(spacing: 12) {
            HStack(spacing: 15) {
                // Millage
                VStack(alignment: .leading, spacing: 2) {
                    Text("Mileage")
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Text("\(vm.currentRange)")
                            .font(.system(.subheadline, design: .rounded))
                            .bold()
                        
                        Text("km").font(.caption2).foregroundStyle(.secondary)
                    }
                }
                
                Divider()
                    .frame(height: 20)
                
                // Total Parts
                HStack(spacing: 4) {
                    Image(systemName: "wrench.and.screwdriver.fill")
                    Text("\(vm.totalMaintenances)")
                        .bold()
                }
                .foregroundStyle(.primary)
                .font(.default)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.white.opacity(0.65)) // Look de cristal
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            // Filter Button (Acción)
            Button {
                // Acción de filtro
            } label: {
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
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MaintenanceFilterView(vm: .init())
}
