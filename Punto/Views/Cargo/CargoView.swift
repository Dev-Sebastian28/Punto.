//
//  CargoView.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//

import SwiftUI


// MARK: - Filter Model
enum CargoFilter: String, CaseIterable {
    case all      = "Todos"
    case weight   = "Peso"
    case distance = "Distancia"
    case type     = "Tipo"
    
    var icon: String {
        switch self {
        case .all:      return "square.grid.2x2"
        case .weight:   return "scalemass.fill"
        case .distance: return "location.fill"
        case .type:     return "shippingbox.fill"
        }
    }
}

// MARK: - CargoView
struct CargoView: View {
    @State private var selectedFilter: CargoFilter = .all
    @State private var searchText: String = ""
    
    // Preview data
    private let cargos: [Cargo] = [
        Cargo(id: 1, origine: "Bogotá, Calle 2, Catedral",    destination: "Bogotá, Calle 12, 10 de Julio", weight: 22, type: "Máquina Industrial", distance: 12),
        Cargo(id: 2, origine: "Medellín, El Poblado",          destination: "Cali, Granada",                 weight: 5,  type: "Electrodomésticos",   distance: 45),
        Cargo(id: 3, origine: "Barranquilla, Centro",          destination: "Cartagena, Bocagrande",         weight: 10, type: "Materiales",           distance: 120),
        Cargo(id: 4, origine: "Cali, Chipichape",              destination: "Pereira, Centro",               weight: 3,  type: "Paquetería",           distance: 90),
        Cargo(id: 5, origine: "Bogotá, Usaquén",               destination: "Tunja, Parque Central",         weight: 8,  type: "Alimentos",            distance: 150),
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        searchBar
                            .padding(.top, 16)
                        filterSection
                        cargoList
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
            }
        }
    }
    
    // MARK: - Header
    private var header: some View {
        ZStack(alignment: .bottom) {
            // Background
            LinearGradient(
                colors: [.blue, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea(edges: .top)

            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white.opacity(0.15))
                        .frame(width: 48, height: 48)
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Cargas disponibles")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                        Text("Colombia, Bogotá")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
                .font(.subheadline)
            
            TextField("Buscar por ciudad, tipo...", text: $searchText)
                .font(.subheadline)
            
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.white)
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Filters
    private var filterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(CargoFilter.allCases, id: \.self) { filter in
                    FilterChip(
                        filter: filter,
                        isSelected: selectedFilter == filter
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedFilter = filter
                        }
                    }
                }
            }
        }
    }
    
    
    private var cargoList: some View {
        LazyVStack(spacing: 12) {
            ForEach(cargos) { cargo in
                CargoCardView(cargo: cargo)
            }
        }
    }
}

private struct FilterChip: View {
    let filter: CargoFilter
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: filter.icon)
                    .font(.caption)
                Text(filter.rawValue)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(isSelected ? .white : .blue)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(
                Capsule()
                    .fill(isSelected
                          ? .blue
                          : .blue.opacity(0.08))
            )
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    CargoView()
}
