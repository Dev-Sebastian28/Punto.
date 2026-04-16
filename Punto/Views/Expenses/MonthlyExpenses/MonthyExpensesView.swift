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
    @State private var selectedMonthInformation: String? = nil
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
                
                VStack(alignment: .leading) {
                    Text("Analysis of your expenses:")
                    Text("Scroll to see the trend")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        Chart(data) { month in
                            BarMark(
                                x: .value("Shape Type", months[month.month]),
                                y: .value("Total Count", month.amount)
                            ).cornerRadius(5)
                        }
                    .chartScrollableAxes(.horizontal)
                    .chartXVisibleDomain(length: 6)
                    .chartXSelection(value: $selectedMonthInformation)
                    
                    if let selectedMonthInformation {
                        selectedMonthView(month: selectedMonthInformation)
                    }
                }
                topSpendingCategories
                
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
    private var topSpendingCategories: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Text("Top Spending Categories")
                    .font(.title3.bold())
                Spacer()
                Button {
                    
                } label: {
                    Text("Add")
                        .foregroundStyle(.white)
                }
            }
            ForEach(categories, id: \.title) { category in
                CategoryView(category: category)
            }
            
        }.padding()
            .background(
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray.opacity(0.6),radius: 1.5)
            )
    }
    
    private func selectedMonthView(month: String) -> some View {
        VStack {
            if let index = months.firstIndex(where: {$0.uppercased() == month.uppercased()}) {
                HStack {
                    Image(systemName: "calendar")
                    Text(month.capitalized)
                    
                    Spacer()
                    
                    Text("Total: 10")
                }.foregroundStyle(.black.opacity(0.6))
                
                HStack {
                    Text(data[index].amount.formatted(.number.grouping(.automatic)))
                        .foregroundStyle(.green)
                        .customBackground(color: .green.opacity(0.25))
                    
                    Spacer()
                    Text(data[index].amount.formatted(.number.grouping(.automatic)))
                        .foregroundStyle(.red)
                        .customBackground(color: .red.opacity(0.25))

                }.customBackground(color: .white)


            } else {
                Text("Error")
            }
        }.customBackground(color: .blue.opacity(0.2))
    }
}

struct Category {
    var title: String
    var amount: String
    var color: Color
    var porcent: Double
    var image: String
}

struct CategoryView: View {
let category: Category
var body: some View {
    HStack {
        Image(systemName: category.image)
            .foregroundStyle(category.color)
            .padding(13)
            .background(category.color.opacity(0.2).cornerRadius(10))
        VStack {
            HStack {
                Text(category.title)
                    .font(.subheadline.bold())
                Spacer()
                Text(category.amount)
            }
            ProgressView(value: 0.25) {
                
            }.progressViewStyle(CustomProgressViewStyle())
        }
    }
}
}

private struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .frame(height: 10)
            .cornerRadius(.infinity)
            .scaleEffect(y: 2)
    }
}



#Preview {
    MonthlyExpensesView()
}
