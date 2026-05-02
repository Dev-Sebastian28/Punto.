//
//  AddDriverView.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/04/26.
//

import SwiftUI

struct AddDriverView: View {
    @State private var vm: AddDriverViewModel
    @State private var selectedVehicleIndex: Int = 0
    @State private var isAddDriverPresented: Bool = false

    // Message toast state
    @State private var showMessage: Bool = false

    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    @Environment(AppCoordinator.self) var coordinator


    private var isPortrait: Bool {
        vSizeClass == .regular
    }

    init(user: User) {
        vm = .init(user: user)
    }

    var body: some View {
        ZStack(alignment: .top) {
            // Background
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack {
                header
                    .padding(.horizontal, 10)
                    .padding(.top, 0)
                    .padding(.bottom, 12)

                Divider()

                if isPortrait {
                    portraitContent
                } else {
                    landscapeContent
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .padding(.horizontal)

            if showMessage {
                MessageToast(message: vm.message)
            }
        }
        // Watch the message from VM and trigger animation
        .onChange(of: vm.message) { _, newValue in
            guard !newValue.isEmpty else { return }
            presentMessage()
        }
        .sheet(isPresented: $isAddDriverPresented) {
            AddDriverForm(vm: vm, index: selectedVehicleIndex)
                .presentationBackground(.white)
                .presentationDetents([.height(310)])
        }
    }
    
    private func presentMessage() {
        showMessage = true
        Task {
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            showMessage = false

        }

    }
    
    private var header: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Fleet Drivers")
                    .font(.system(.title2, design: .rounded, weight: .bold))

                Text("Invite drivers to manage tasks, protocols and routes. You can also drive your own vehicle.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            laterButton
        }
    }
    
    private var portraitContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(vm.vehicles.enumerated(), id: \.element.vehicleInformation.id) {
                    index,
                    vehicle in
                    VehicleDriversCard(
                        vehicle: vehicle,
                        vm: vm,
                        index: index,
                        isPresented: $isAddDriverPresented
                    )
                }
            }
        }
    }
    
    private var landscapeContent: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(vm.vehicles.enumerated(), id: \.element.vehicleInformation.id) {
                    index,
                    vehicle in
                    VehicleDriversCard(
                        vehicle: vehicle,
                        vm: vm,
                        index: index,
                        isPresented: $isAddDriverPresented
                    )
                        .frame(width: 340)
                }
            }
        }
    }
    
    private var laterButton: some View {
        Button {
            coordinator.onBoardingCoordinator.didFinishOnBoarding()
        } label: {
            Text("Later")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
                .genericCapsuleBackground(color: .gray.opacity(0.1))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddDriverView(user: .mock)
        .environment(AppCoordinator(appState: AppState()))
}
