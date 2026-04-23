import SwiftUI

struct AddExpenseView: View {
    @State private var showScanner = false
    @State private var scannedImages: [UIImage] = []
    @State private var errorMessage: String?
    @Environment(\.dismiss) var dismiss
    
    @State private var expense: Expense = .init(
        name: "",
        description: "",
        amount: 0.0,
        date: Date(),
        type: ""
    )
    
    var vm: ExpenseViewModel
    
    private var isValid: Bool {
        !expense.name.isEmpty && expense.amount != 0.0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Title
            Text("Title").font(.headline)
            TextFieldComp(
                text: $expense.name,
                prompt: "Ex: re-fill gasoline",
                image: "circle",
                color: .gray.opacity(0.4)
            )
            
            // Description
            Text("Description").font(.headline)
            TextFieldComp(
                text: $expense.name,
                prompt: "Ex: I received 500 $",
                image: "text.alignleft",
                color: .gray.opacity(0.4)
            )
            
            // Amount
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Text("Amount").font(.headline)
                    Text("*").foregroundStyle(.red)
                }
                HStack(spacing: 8) {
                    Image(systemName: "dollarsign.circle.fill").foregroundStyle(.secondary)
                    TextField("0.00", value: $expense.amount, format: .number.precision(.fractionLength(2)))
                        .keyboardType(.decimalPad)
                }
                .padding(12)
                .background(.thinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color.gray.opacity(0.25), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            
            // Buttons
            button
        }
        .padding()
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var button: some View {
        HStack(spacing: 12) {
            Button {
                vm.addExpense(expense)
                dismiss()
            }
            label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Expense").bold()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
            }
            .disabled(!isValid)
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .shadow(color: .green.opacity(0.25), radius: 8, x: 0, y: 4)

        }
    }
}


