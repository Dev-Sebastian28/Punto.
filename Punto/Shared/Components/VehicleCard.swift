//
//  VehicleCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/04/26.
//
import SwiftUI

struct VehicleCard: View {
    let info: VehicleInformation
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // 1. Imagen de fondo
            Group {
                if let urlString = info.imageUrl, let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .overlay(ProgressView())
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            placeholderView
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    placeholderView
                }
            }
            .frame(height: 220) // Altura fija para que la lista se vea ordenada
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle()) // Mejora el área de toque
            
            // 2. Gradiente para legibilidad del texto
            LinearGradient(
                colors: [.clear, .black.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // 3. Información del Vehículo
            VStack(alignment: .leading, spacing: 4) {
                Text("\(info.brand) \(info.model)")
                    .font(.title3.bold())
                
                HStack {
                    Text(info.plate)
                        .font(.caption.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.white.opacity(0.2))
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    Text("\(info.year)")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            .foregroundStyle(.white)
            .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
    // Vista de respaldo si no hay imagen o falla la carga
    private var placeholderView: some View {
        ZStack {
            Color.gray.opacity(0.1)
            Image(systemName: "truck.box.fill")
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    VehicleCard(info: VehicleInformation(
        plate: "GHT-990",
        brand: "Kenworth",
        model: "T800",
        year: 2022,
        mileage: 5000,
        engine: "X15",
        transmission: .manual,
        fuel: .diesel
    )).preferredColorScheme(.dark)
}
