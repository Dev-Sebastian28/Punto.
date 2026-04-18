//
//  VehicleCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/04/26.
//
import SwiftUI

struct vehicleCard:  View {
    let info: VehicleInformation
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(info.image)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(alignment: .bottomLeading) {
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.55)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }.overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(info.brand) \(info.model)")
                            .font(.title2.bold())
                        Text(info.plate)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .foregroundStyle(.white)
                    .padding(16)
                }
        }
    }
}

#Preview {
   // vehicleCard(info: <#T##VehicleInformation#>)
}
