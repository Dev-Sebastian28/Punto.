//
//  AddExpenseView.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//

import SwiftUI

struct AddExpenseView: View {
    @Binding var collection: [Expense]
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var amount: Double

    init(collection: Binding<[Expense]>, isPresented: Binding<Bool>, amount: Double = 0) {
        self._collection = collection
        self._isPresented = isPresented
        self._amount = State(initialValue: amount)
    }


    var isValid: Bool {
        !name.isEmpty && amount != 0.0
    }

    var body: some View {
        ZStack {
            VStack(spacing: 20) {

                // Card with fields
                VStack(spacing: 16) {

                    // Title
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 4) {
                            Text("Title").font(.headline)
                            Text("*").foregroundStyle(.red)
                        }
                        HStack(spacing: 8) {
                            TextField("Ex: re-fill gasoline", text: $name)
                        }
                        .padding(12)
                        .background(.thinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(Color.gray.opacity(0.25), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Description").font(.headline)
                        HStack(spacing: 8) {
                            Image(systemName: "text.alignleft").foregroundStyle(.secondary)
                            TextField("Ex: I received 500 pesos", text: $description)
                                .sentencesAutocapitalizationIfAvailable()
                        }
                        .padding(12)
                        .background(.thinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(Color.gray.opacity(0.25), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }

                    // Amount
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 4) {
                            Text("Amount").font(.headline)
                            Text("*").foregroundStyle(.red)
                        }
                        HStack(spacing: 8) {
                            Image(systemName: "dollarsign.circle.fill").foregroundStyle(.secondary)
                            TextField("0.00", value: $amount, format: .number.precision(.fractionLength(2)))
                                .decimalKeyboardIfAvailable()
                        }
                        .padding(12)
                        .background(.thinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(Color.gray.opacity(0.25), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }

                    // Actions
                    HStack(spacing: 12) {
                        Button {
                            collection.addExpense(
                                expense: Expense(
                                    name: name,
                                    description: description,
                                    amount: amount,
                                    date: .now,
                                    type: "Manual"
                                )
                            )
                            isPresented.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add Expense").bold()
                            }
                            .frame(width: 200, height: 4)
                            .padding(.vertical, 14)
                        }
                        .disabled(!isValid)
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .shadow(color: .green.opacity(0.25), radius: 8, x: 0, y: 4)


                        Button {
                            // Camera action here
                        } label: {
                            Image(systemName: "camera.fill")
                                .frame(width: 52, height: 52)
                        }
                        .frame(width: 54, height: 54)
                        .buttonStyle(.bordered)
                        .tint(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                }
                .padding(16)
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    AddExpenseView(collection: .constant(.init()), isPresented: .constant(true))
}
