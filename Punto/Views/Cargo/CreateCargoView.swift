//
//  CreateCargoView.swift
//  Punto
//
//  Created by Sebastian Garcia on 11/05/26.
//

import SwiftUI

struct CreateCargoView: View {

    // MARK: - Cargo Details
    @State private var cargoName: String = ""
    @State private var cargoType: String = ""
    @State private var origin: String = ""
    @State private var destination: String = ""

    // MARK: - Measurements
    @State private var weightKg: String = ""
    @State private var volumeCubicMeters: String = ""
    @State private var price: String = ""

    // MARK: - Delivery
    @State private var dueDate: Date =
    Calendar.current.date(byAdding: .day, value: 7, to: .now) ?? .now

    // MARK: - Restricted Information
    @State private var contactName: String = ""
    @State private var contactPhone: String = ""
    @State private var exactOriginAddress: String = ""
    @State private var exactDestinationAddress: String = ""
    @State private var notes: String = ""

    // MARK: - UI State
    @State private var isSubmitting: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    @Environment(\.dismiss) private var dismiss

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    cargoDetailsSection

                    locationsSection

                    measurementsSection

                    pricingSection

                    restrictedInfoSection

                    submitButton
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Create Cargo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
}

// MARK: - Sections
private extension CreateCargoView {

    var cargoDetailsSection: some View {
        sectionCard(
            title: "Cargo Details",
            subtitle: "Basic information about the shipment"
        ) {
            CustomTextField(
                title: "Cargo Name",
                placeholder: "Industrial Machinery",
                text: $cargoName
            )

            CustomTextField(
                title: "Cargo Type",
                placeholder: "Electronics, Furniture, Food...",
                text: $cargoType
            )
        }
    }

    var locationsSection: some View {
        sectionCard(
            title: "Locations",
            subtitle: "Where the cargo will be picked up and delivered"
        ) {
            CustomTextField(
                title: "Origin",
                placeholder: "Houston, TX",
                text: $origin
            )

            CustomTextField(
                title: "Destination",
                placeholder: "Miami, FL",
                text: $destination
            )
        }
    }

    var measurementsSection: some View {
        sectionCard(
            title: "Measurements",
            subtitle: "Cargo dimensions and weight"
        ) {
            HStack(spacing: 16) {

                CustomNumberField(
                    title: "Weight",
                    placeholder: "0",
                    suffix: "kg",
                    text: $weightKg
                )

                CustomNumberField(
                    title: "Volume",
                    placeholder: "0",
                    suffix: "m³",
                    text: $volumeCubicMeters
                )
            }
        }
    }

    var pricingSection: some View {
        sectionCard(
            title: "Pricing & Deadline",
            subtitle: "Set the payment and delivery date"
        ) {
            CustomNumberField(
                title: "Price",
                placeholder: "0",
                suffix: "USD",
                text: $price
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("Delivery Deadline")
                    .font(.subheadline)
                    .fontWeight(.medium)

                DatePicker(
                    "",
                    selection: $dueDate,
                    displayedComponents: .date
                )
                .labelsHidden()
                .datePickerStyle(.graphical)
            }
        }
    }

    var restrictedInfoSection: some View {
        sectionCard(
            title: "Restricted Information",
            subtitle: "Visible only to the accepted driver"
        ) {

            CustomTextField(
                title: "Contact Name",
                placeholder: "John Doe",
                text: $contactName
            )

            CustomTextField(
                title: "Phone Number",
                placeholder: "+1 555 123 4567",
                text: $contactPhone
            )
            .keyboardType(.phonePad)

            CustomTextField(
                title: "Pickup Address",
                placeholder: "123 Main Street",
                text: $exactOriginAddress
            )

            CustomTextField(
                title: "Delivery Address",
                placeholder: "456 Sunset Avenue",
                text: $exactDestinationAddress
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("Additional Notes")
                    .font(.subheadline)
                    .fontWeight(.medium)

                TextField(
                    "Special instructions...",
                    text: $notes,
                    axis: .vertical
                )
                .lineLimit(4...8)
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
    }

    var submitButton: some View {
        Button {
            Task {
                await submit()
            }
        } label: {
            HStack {
                if isSubmitting {
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: "shippingbox.fill")
                    Text("Publish Cargo")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isFormValid ? Color.blue : Color.gray.opacity(0.4))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .disabled(!isFormValid || isSubmitting)
        .padding(.top, 8)
    }
}

// MARK: - Components
private extension CreateCargoView {

    func sectionCard<Content: View>(
        title: String,
        subtitle: String,
        @ViewBuilder content: () -> Content
    ) -> some View {

        VStack(alignment: .leading, spacing: 18) {

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            content()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(
            color: .black.opacity(0.04),
            radius: 10,
            x: 0,
            y: 4
        )
    }
}

// MARK: - Validation
private extension CreateCargoView {

    var isFormValid: Bool {
        !cargoName.isEmpty &&
        !cargoType.isEmpty &&
        !origin.isEmpty &&
        !destination.isEmpty &&
        Double(weightKg) != nil &&
        Double(volumeCubicMeters) != nil &&
        Double(price) != nil &&
        !contactName.isEmpty &&
        !contactPhone.isEmpty &&
        !exactOriginAddress.isEmpty &&
        !exactDestinationAddress.isEmpty
    }
}

// MARK: - Submit
private extension CreateCargoView {

    func submit() async {

        guard
            let weight = Double(weightKg),
            let volume = Double(volumeCubicMeters),
            let priceValue = Double(price)
        else { return }

        let cargo = Cargo(
            id: UUID(),
            ownerID: UUID(),
            cargoName: cargoName,
            cargoType: cargoType,
            cargoStatus: nil,
            origin: origin,
            destination: destination,
            weightKg: weight,
            volumeCubicMeters: volume,
            distanceToCargoKm: 0,
            distanceToDestinationKm: 0,
            price: priceValue,
            dueDate: dueDate,
            createdAt: .now,
            restrictedInfo: CargoRestrictedInfo(
                contactName: contactName,
                contactPhone: contactPhone,
                exactOriginAddress: exactOriginAddress,
                exactDestinationAddress: exactDestinationAddress,
                notes: notes.isEmpty ? nil : notes
            )
        )

        print(cargo)

        isSubmitting = true
        defer { isSubmitting = false }

        do {
            // try await cargoService.createCargo(cargo)
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}

// MARK: - Reusable Fields
struct CustomTextField: View {

    let title: String
    let placeholder: String

    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)

            TextField(placeholder, text: $text)
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

struct CustomNumberField: View {

    let title: String
    let placeholder: String
    let suffix: String

    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)

            HStack {

                TextField(placeholder, text: $text)
                    .keyboardType(.decimalPad)

                Text(suffix)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

// MARK: - Preview
#Preview {
    CreateCargoView()
}
