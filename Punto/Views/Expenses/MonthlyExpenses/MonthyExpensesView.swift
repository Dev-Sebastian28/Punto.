//
//  YearOverView.swift
//  Punto
//
//  Created by Sebastian Garcia on 8/04/26.
//

import SwiftUI

struct MonthlyExpensesView: View {
    let today = Date()
    let componets = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    
    let months = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"]
    
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
                
                // Create table incomes and expenses
                
                topSpendingCategories
                
                // Create Analitich learn how
                
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
            Button {} label: {
                Image(systemName: "chevron.left")
                
            }
            
            Spacer()
            VStack {
                Text("Month").font(.title2.bold())
                Text("2026").foregroundStyle(.secondary)
                
            }
            Spacer()
            Button {} label: {
                Image(systemName: "chevron.right")
                
            }
        }
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
                        .customBackground(color: .blue)
                }

            }
            
            Category(title: "Food & Dining", amount: "$845", color: .blue, porcent: 0.4, image: "fork.knife")
            
        }.padding()
            .background(
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray.opacity(0.6),radius: 1.5)
            )
    }
}

private struct Category: View {
    var title: String
    var amount: String
    var color: Color
    var porcent: Double
    var image: String
    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundStyle(color)
                .padding(13)
                .background(color.opacity(0.2).cornerRadius(10))
            VStack {
                HStack {
                    Text(title)
                        .font(.subheadline.bold())
                    Spacer()
                    Text(amount)
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
