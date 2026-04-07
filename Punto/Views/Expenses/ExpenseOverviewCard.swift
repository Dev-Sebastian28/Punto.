//
//  ExpenseOverviewCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 12/03/26.
//
import SwiftUI
import Foundation

struct ExpenseOverviewCard: View {
    var balance: Double
    var profit: Double
    var losses: Double
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 200, alignment: .center)
            .foregroundStyle(
                RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.green.mix(with: .mint, by: 0.25), location: 0.0),
                        .init(color: Color.green, location: 0.55),
                        .init(color: Color.green.mix(with: .teal, by: 0.35), location: 0.9)
                    ]),
                    center: .init(x: 0.25, y: 0.2),
                    startRadius: 10,
                    endRadius: 380
                )
            )
    
            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 6)
        
            .overlay(alignment: .leading) {
                VStack (alignment: .leading, spacing: 10){
                    Group {
                        Text("Balance")
                            .font(.title2)
                        Text(balance, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .font(.largeTitle)
                            .bold()
                    }.foregroundStyle(.white)

                    HStack (spacing: 40){

                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                AngularGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color.green.mix(with: .teal, by: 0.45), location: 0.0),
                                        .init(color: Color.green, location: 0.6),
                                        .init(color: Color.green.mix(with: .mint, by: 0.35), location: 1.0)
                                    ]),
                                    center: .center,
                                    angle: .degrees(210)
                                )
                            )
                        
                             // Profit Squere
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.ultraThinMaterial.opacity(0.25))
                            )
                            .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                            .overlay(alignment: .leading){
                                VStack (alignment: .leading, spacing: 10) {
                                    HStack{
                                        Image(systemName: "arrow.up.forward")
                                            .foregroundStyle(.blue)
                                            .bold()
                                        Text("Profit")
                                            .bold()
                                    }
                                    Text(profit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                        .font(.title2)
                                        .foregroundStyle(.white)
                                        .bold()
                                }.padding(.leading, 10)
                            }
                        
                        
                        // Losses Squere
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color.green.mix(with: .yellow, by: 0.25).opacity(0.95), location: 0.0),
                                        .init(color: Color.green, location: 0.55),
                                        .init(color: Color.green.mix(with: .mint, by: 0.15), location: 1.0)
                                    ]),
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                )
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.ultraThinMaterial.opacity(0.25))
                            )
                            .overlay(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.18), Color.white.opacity(0.0)],
                                    startPoint: .topLeading,
                                    endPoint: .center
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            )
                            .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                            .overlay(alignment: .leading){
                                VStack (alignment: .leading, spacing: 10) {
                                    HStack{
                                        Image(systemName: "arrow.down.right")
                                            .foregroundStyle(.red)
                                            .bold()
                                        Text("Losses")
                                            .bold()
                                    }
                                    Text(losses, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                        .font(.title2)
                                        .foregroundStyle(.white)
                                        .bold()
                                }.padding(.leading, 10)
                            }
                    }
                }.padding()
            }
    }
}
