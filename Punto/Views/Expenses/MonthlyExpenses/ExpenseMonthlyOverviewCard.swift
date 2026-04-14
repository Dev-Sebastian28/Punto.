//
//  ExpenseOverviewCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 12/03/26.
//
import SwiftUI
import Foundation

struct ExpenseMonthlyOverviewCard: View {
    var balance: Double
    var profit: Double
    var losses: Double
    var bcColor: [Color]
    var body: some View {
        VStack(alignment: .leading, spacing: 10 ) {
            VStack(alignment: .leading,spacing: 2) {
                Text("Total Balance:")
                    .font(.title).bold()
                    .foregroundStyle(.white.opacity(0.82))
                Text(balance, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
            }
            
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "arrow.down.right")
                            .foregroundStyle(.red)
                            .bold()
                        Text("Losses")
                            .bold()
                    }
                    .foregroundStyle(.red.opacity(0.6))
                    
                    Text(losses, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title2)
                        .foregroundStyle(.black)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.white.opacity(0.85))
                .cornerRadius(15)
                
                VStack {
                    
                    HStack {
                        Image(systemName: "arrow.up.forward")
                            .foregroundStyle(.blue)
                            .bold()
                        Text("Profit")
                            .bold()
                    }
                    .foregroundStyle(.blue.opacity(0.6))
                    
                    Text(profit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title2)
                        .foregroundStyle(.black)
                        .bold()
                    
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.white.opacity(0.85))
                .cornerRadius(15)
            }
        }
        .padding(20)
        .background(
            LinearGradient(colors: bcColor, startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.white.opacity(0.14), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .brandGreenDark.opacity(0.24), radius: 18, x: 0, y: 10)
    }
    
   
}

#Preview {
    ExpenseMonthlyOverviewCard(balance: 0.0, profit: 0.0, losses: 0.0, bcColor: [.green, .green.opacity(0.3), .white.opacity(0.1)] )
}
