import SwiftUI

struct ExpenseFactory: FactoryQuickInfoCard {
    let vehicle: any Vehicle

    private var sortedExpenses: [Expense] {
        vehicle.expenses.sorted { $0.date > $1.date }
    }

    private var quickInfo: [QuickSummary] {
        let total = vehicle.expenses.reduce(0) { $0 + $1.amount }
        return [
            QuickSummary(title: "Total", value: Int(total), color: .green)
        ]
    }

    func make() -> some View {
        QuickInfoCard(
            title: "Expenses",
            icon: "creditcard.fill",
            iconColor: .green,
            items: sortedExpenses,
            quickInfo: quickInfo
        ) { expense in
            AnyView(ExpenseRow(expense: expense))
        }
    }
}

// MARK: - Expense Row

private struct ExpenseRow: View {
    let expense: Expense

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.title)
                    .font(.body.bold())
                Text(expense.category ?? "General")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("$\(expense.amount, specifier: "%.2f")")
                    .font(.body.bold())
                    .foregroundStyle(.green)
                DateBadge(date: expense.date)
            }
        }
        .frame(maxHeight: 60)
    }
}