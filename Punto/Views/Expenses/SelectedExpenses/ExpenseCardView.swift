//
//  ExpenseCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 12/03/26.
//
import SwiftUI

struct ExpenseCardView: View {
    let expense: Expense

    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "fuelpump.fill")
                        .foregroundStyle(expense.dominatColor)
                        .bold()
                        .frame(width: 50, height: 50)
                        .background(expense.dominatColor.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(10)

                    VStack (alignment: .leading,spacing: 5) {
                        Text("\(expense.name)")
                            .font(.title3)
                            .bold()
                        HStack {
                            Text(expense.date, format: .dateTime.day().month(.abbreviated).year())
                                .fontWeight(.light)
                                .foregroundStyle(.gray)

                            Spacer()

                            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .font(.title2)
                                .foregroundStyle(expense.dominatColor)
                                .bold()
                                .padding(.trailing)
                        }
                    }
                }
            }.background {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 76)
                    .foregroundStyle(.white)
                    .shadow(radius: 1)
            }
    }
}

#Preview {
    ExpenseCardView(expense: .init(id: .init(), name: "Food", description: "I ate a lot of food", amount: 200, date: .now, type: ""))
}
