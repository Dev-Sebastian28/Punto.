//
//  RouteDetail.swift
//  Punto
//
//  Created by Sebastian Garcia on 6/05/26.
//
import SwiftUI


// MARK: - Route Detail
struct CargoRouteDetail: View {
    let cargo: Cargo
    var body: some View {
        VStack(alignment: .leading) {
            CardHeader(icon: "location.fill", title: "Route Information", color: .blue)
            
            HStack(alignment: .top, spacing: 14) {
                
                lineStop
                
                VStack(alignment: .leading, spacing: 0) {
                    routeStop(label: "Origin", place: "\(cargo.origin)")
                    Spacer().frame(height: 16)
                    routeStop(label: "Destination", place: "\(cargo.destination)")
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Total Kilometers:")
                    Text("10.000 km")
                        .foregroundStyle(.secondary)
                }
                
            }.frame(minHeight: 80)
        }.genericRoundedBackgroundShadow(color: .gray)
    }
    
    private func routeStop(label: String, place: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(.secondary)
                .tracking(0.5)
            Text(place)
                .font(.subheadline.weight(.medium))
        }
    }
    private var lineStop: some View {
        VStack(spacing: 0) {
            Circle().fill(Color.blue).frame(width: 10, height: 10)
            Rectangle()
                .fill(
                    LinearGradient(colors: [.blue, .green],
                                   startPoint: .top, endPoint: .bottom)
                )
                .frame(width: 2)
                .frame(maxHeight: .infinity)
            Circle().fill(Color.green).frame(width: 10, height: 10)
        }
        .padding(.top, 4)
    }
}

#Preview {
    CargoRouteDetail(cargo: .mockPending)
}
