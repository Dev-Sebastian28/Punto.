//
//  ExpenseCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 12/03/26.
//
import SwiftUI

struct ExpenseCardView: View {
    var expense: Expense
    var color: Bool {
        if expense.amount >= 0 {
            return true
        } else {
            return false
        }
    }
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 76)
            .foregroundStyle(.white)
            .shadow(radius: 1)
            .overlay(alignment: .leading) {
                HStack {
                    Image(systemName: "fuelpump.fill")
                        .foregroundStyle(.red)
                        .bold()
                        .frame(width: 50, height: 50)
                        .background(Color.red.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()

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
                                .foregroundStyle(color ? .green : .red)
                                .bold()
                                .padding(.trailing)
                        }
                    }
                }
            }.padding(.horizontal, 6)

    }
}

#Preview {
    ExpenseCardView(expense: .init(id: .init(), name: "Food", description: "I ate a lot of food", amount: -200, date: .now, type: ""))
}
