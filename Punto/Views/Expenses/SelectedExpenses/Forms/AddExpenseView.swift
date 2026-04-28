import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @State private var expense: Expense = .init(
        name: "",
        description: "",
        amount: 0.0,
        date: Date(),
        type: ""
    )
    let vm: ExpenseViewModel
    
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
                leadingIcon: "circle",
                color: .gray.opacity(0.4)
            )
            
            // Description
            Text("Description").font(.headline)
            TextFieldComp(
                text: Binding(
                    get: { expense.description ?? "" },
                    set: { expense.description = $0.trimmingCharacters(in: .whitespaces) }
                ),
                prompt: "Ex: I received 500 $",
                leadingIcon: "text.alignleft",
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
            
            // Button
            DButtonComp(text: "Add Expenses", color: .green, image: "plus.circle.fill") {
                vm.addExpense(expense)
                dismiss()
            }
        }
        .padding()
        .ignoresSafeArea(edges: .bottom)
    }
}


