//
//  YearOverView.swift
//  Punto
//
//  Created by Sebastian Garcia on 8/04/26.
//

import SwiftUI
import Charts

struct MonthyExpense: Identifiable {
    var id: Int
    let month: Int
    let amount: Int
    
    init(month: Int, amount: Int) {
        self.id = month
        self.month = month
        self.amount = amount
    }
}

struct MonthlyExpensesView: View {
    @State private var monthIndex: Int = 0
    let months: [String] = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"
    ]
    let data:[MonthyExpense] = [ .init(month: 0, amount: .random(in: 0...100000)), .init(month: 1, amount: .random(in: 0...100000)), .init(month: 2, amount: .random(in: 0...100000)), .init(month: 3, amount: .random(in: 0...100000)),.init(month: 4, amount: .random(in: 0...100000)), .init(month: 5, amount: .random(in: 0...100000)), .init(month: 6, amount: .random(in: 0...100000)), .init(month: 7, amount: .random(in: 0...100000))
    ]
    let categories: [Category] = [
        Category(title: "Food & Dining", amount: "$845", color: .blue, porcent: 0.4, image: "fork.knife"), Category(title: "Food & Dining", amount: "$845", color: .blue, porcent: 0.4, image: "fork.knife"), Category(title: "Food & Dining", amount: "$845", color: .blue, porcent: 0.4, image: "fork.knife"), Category(title: "Food & Dining", amount: "$845", color: .blue, porcent: 0.4, image: "fork.knife")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                header
                selectedMonth
                ExpenseMonthlyOverviewCard(
                    balance: 0.0,
                    profit: 0.0,
                    losses: 0.0,
                    bcColor: [.blue.opacity(0.8),.green,.brandGreen  ]
                )
                GraphView()
                CategoriesView(categories: categories)
            }.padding(.horizontal)
        }.ignoresSafeArea(edges: .bottom)
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Month Overview")
                .font(.system(size: 25, weight: .black))
                .foregroundColor(.blue)
                .textCase(.uppercase)
            
            Text("Track your financial health month by month. See your spending trends and set goals for the year.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineSpacing(4)
        }
    }
    private var selectedMonth: some View {
        HStack {
            Button {
                if monthIndex > 0 {
                    monthIndex -= 1
                }
            } label: {
                Image(systemName: "chevron.left")
                
            }.disabled(monthIndex == 0)
            
            Spacer()
            VStack {
                Text(months[monthIndex])
                    .font(.title2.bold())
                Text("2026")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
            }
            Spacer()
            Button {
                if monthIndex < 11 {
                    monthIndex += 1
                }
            } label: {
                Image(systemName: "chevron.right")
                
            }.disabled(monthIndex == 11)
        }
        .font(.title)
        .padding()
        .background(
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .gray.opacity(0.6),radius: 1.5)
        )
    }
}

#Preview {
    MonthlyExpensesView()
}
