//
//  GraphView.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//
import SwiftUI
import Charts

struct GraphView: View {
    @State private var selectedMonthInformation: String? = nil
    let data:[MonthyExpense] = [ .init(month: 0, amount: .random(in: 0...100000)), .init(month: 1, amount: .random(in: 0...100000)), .init(month: 2, amount: .random(in: 0...100000)), .init(month: 3, amount: .random(in: 0...100000)),.init(month: 4, amount: .random(in: 0...100000)), .init(month: 5, amount: .random(in: 0...100000)), .init(month: 6, amount: .random(in: 0...100000)), .init(month: 7, amount: .random(in: 0...100000))
    ]
    let months: [String] = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"
    ]


    var body: some View {
        VStack(alignment: .leading) {
                title
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
    }
    @ViewBuilder
    private var title: some View {
        Text("Analysis of your expenses:")
        Text("Scroll to see the trend")
            .font(.caption)
            .foregroundStyle(.secondary)
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

#Preview {
    GraphView()
}
