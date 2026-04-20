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

    @Environment(NavigationRouter.self) var router
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass

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

            // Main layout
            VStack(spacing: 0) {
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

            if showMessage {
                messageToast
            }
        }
        // Watch the message from VM and trigger animation
        .onChange(of: vm.mesage) { _, newValue in
            guard !newValue.isEmpty else { return }
            presentMessage()
        }
        .sheet(isPresented: $isAddDriverPresented) {
            AddDriverForm(vm: vm, index: selectedVehicleIndex)
                .presentationBackground(.white)
                .presentationDetents([.height(310)])
        }
    }

    // MARK: – Toast
    private var messageToast: some View {
        HStack(spacing: 10) {
            Text(vm.mesage)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
        .padding(.top, 8)
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
                ForEach(vm.vehicles.enumerated(), id: \.element.vehicleInformation.id) { index, vehicle in
                    vehicleRow(index: index, vehicle: vehicle)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
    }
    private var landscapeContent: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(vm.vehicles.enumerated(), id: \.element.vehicleInformation.id) { index, vehicle in
                    vehicleRow(index: index, vehicle: vehicle)
                        .frame(width: 340)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
    }
    private func vehicleRow(index: Int, vehicle: Vehicle) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            vehicleCard(info: vehicle.vehicleInformation)

            Divider()

            HStack(alignment: .top, spacing: 12) {
                // Add driver button
                Button {
                    selectedVehicleIndex = index
                    isAddDriverPresented = true
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.system(size: 30))
                            .foregroundStyle(.green)
                        Text("Add")
                            .font(.caption.bold())
                            .foregroundStyle(.green)
                    }
                    .frame(width: 64, height: 70)
                    .background(Color.green.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)

                Divider()
                    .frame(height: 70)

                // Drivers list or empty state
                if vm.user.vehicles[index].drivers.isEmpty {
                    VStack(spacing: 6) {
                        Image(systemName: "person.crop.circle.dashed")
                            .font(.system(size: 28))
                            .foregroundStyle(.tertiary)
                        Text("No drivers yet")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vehicle.drivers, id: \.name) { driver in
                                DriverCardView(driver: driver)
                                    .transition(.scale(scale: 0.85).combined(with: .opacity))
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemGroupedBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color(.separator).opacity(0.5), lineWidth: 0.5)
        )
    }
    private var laterButton: some View {
        Button {
            router.showMainTabs()
        } label: {
            Text("Later")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(
                    Capsule()
                        .fill(Color(.tertiarySystemFill))
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddDriverView(user: .mock)
        .environment(NavigationRouter())
}
