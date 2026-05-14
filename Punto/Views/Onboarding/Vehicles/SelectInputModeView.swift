//
//  SelectVehicleMode.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/05/26.
//
import SwiftUI



struct SelectInputModeView: View {
    @Environment(AppCoordinator.self) var coordinator
    @State private var selectedMode: addVehicleMode = .manual

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            header
            HStack(spacing: 16) {
                ModeCard(
                    icon: "doc.text.fill",
                    title: "Manual",
                    description: "Fill in your vehicle details step by step",
                    color: .blue,
                    isSelected: selectedMode == .manual
                ) { selectedMode = .manual }

                ModeCard(
                    icon: "camera.fill",
                    title: "Property card",
                    description: "Scan your card and we'll fill it for you",
                    color: .green,
                    isSelected: selectedMode == .photo
                ) { selectedMode = .photo }
            }
            Spacer()
            DButtonComp(text: "Continue", color: .blue, image: nil) {
                switch selectedMode {
                case .manual: coordinator.onBoardingCoordinator.addVehicleCoordinator.didSelectManual()
                case .photo:  coordinator.onBoardingCoordinator.addVehicleCoordinator.didSelectPhoto()
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Add your vehicle")
                .font(.largeTitle.weight(.bold))
            Text("Choose how you want to register it")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

struct ModeCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundStyle(color)
                    .frame(width: 64, height: 64)
                    .background(color.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(spacing: 4) {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.platformGroupedBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? color : Color.cardStroke, lineWidth: isSelected ? 2 : 0.5)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SelectInputModeView()
        .environment(AppCoordinator(appState: AppState()))
}
