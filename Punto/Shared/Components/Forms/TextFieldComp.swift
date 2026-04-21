//
//  TextFieldLabel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/03/26.
//
import SwiftUI

struct TextFieldComp: View {
    @Binding var text: String
    var prompt: String
    var image: String
    var color: Color = .secondary
    var isAdaptative: Bool = true
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: image)
                .imageScale(.medium) // Se adapta al tamaño de la fuente
            
            TextField("", text: $text, prompt: Text(prompt))
                // Permite que el texto crezca verticalmente si es necesario
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, isAdaptative ? 12 : 8) // Ajuste dinámico de padding
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(0.2))
        )
        // El secreto: No declarar .frame() para que sea adaptativo
    }
}
#Preview {
    TextFieldComp(
        text: .constant("Vehicle BrandVehicle BrandVehicle BrandVehicle BrandVehicle BrandVehicle BrandVehicle BrandVehicle Brand"),
        prompt: "Vehicle Brand",
        image: "plus",
        isAdaptative: true
    )
}
