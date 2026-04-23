//
//  CargoDetailView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/04/26.
//

import SwiftUI

struct CargoDetailView: View {
    var body: some View {
        VStack(alignment: .leading) {
            header.ignoresSafeArea(edges: .top)
            
            ScrollView {
                RouteDetail()
                CargoDescription()
                CargoVehicleRequirements()
            }
        }
    }
    private var header: some View {
        ZStack(alignment: .leading) {
            Color.blue
            HStack(alignment: .bottom, spacing: 30) {
                Text("Cargo Detail")
                Image(systemName: "shippingbox.fill")
            }
            .padding(.top, 40)
            .font(.system(size: 30, weight: .heavy, design: .none))
            .foregroundStyle(.white)
            .padding(.horizontal)
        }.frame(maxHeight: 120)
    }
}

struct RouteDetail: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "")
                Text("Punto")
            }
            
            Text("Monterrey, Nuevo León")
                .font(.system(size: 14, weight: .semibold, design: .default))
            
            Image(systemName: "arrow.down")
            
            HStack {
                Image(systemName: "")
                Text("Destino")
            }
            
            Text("Monterrey, Nuevo León")
                .font(.system(size: 14, weight: .semibold, design: .default))
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Image("shippingbox.fill")
                    Text("Horario de Recogida")
                }
                Text("Lunes 21 Abril, 8:00 AM")
            }
            
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray.opacity(0.6), radius: 2, x: 0, y: 0)
        )
    }
}

struct CargoDescription: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "shippingbox.fill")
                Text("Información de Carga")
            }
            
            HStack {
                Image(systemName: "")
                Text("Tipo:")
                
                Spacer()
                
                Text("Carga refrigerada")
            }
            
            HStack {
                Image(systemName: "")
                Text("Tipo:")
                
                Spacer()
                
                Text("Carga refrigerada")
            }
            
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "ruler.fill")
                    Text("Dimensiones")
                }
                Text("13m × 2.5m × 2.7m")
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "line.3.horizontal")
                    Text("Description")
                }
                Text("13m × 2.5m × 2.7m")
            }
        }
        .padding(.leading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray.opacity(0.6), radius: 2, x: 0, y: 0)
        )
    }
}

struct CargoVehicleRequirements: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "shippingbox")
                Image(systemName: "truck.box")
                Text("Vehicle Requirements:")
            }
            
            HStack {
                Image(systemName: "")
                Text("Tipo:")
                
                Spacer()
                
                Text("Tractomula, furgon, camioneta, etc")
            }
            
            HStack {
                Image(systemName: "")
                Text("Triler type:")
                
                Spacer()
                
                Text("Triler 10m, 12m, 15m")
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "line.3.horizontal")
                    Text("Description")
                }
                Text("The vehicle needs to be able to transport the cargo.")
            }
        }
        .padding(.leading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray.opacity(0.6), radius: 2, x: 0, y: 0)
        )
    }
}

#Preview {
    CargoDetailView()
}
