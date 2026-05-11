//
//  DriversList.swift
//  Punto
//
//  Created by Sebastian Garcia on 6/05/26.
//

import SwiftUI

struct DriversList: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 200)
            
            VStack {
                HStack(alignment: .top) {
                    Circle()
                        .frame(width: 70, height: 70)
                    VStack(alignment: .leading) {
                        Text("Driver Name")
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(Color.yellow)
                            Text("4.8")
                                .bold()
                            
                        }
                    }
                    
                    Spacer()
                    
                    Text("Available")
                        .foregroundStyle(Color.green)
                        .font(.caption)
                        .fontWeight(.bold)
                        .genericCapsuleBackground(color: .green.opacity(0.1))
                }
                
                Divider()
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 110,height: 70)
                    VStack {
                        Label("van", systemImage: "car")
                        Text("Capacity: 4ton")
                    }

                    Spacer()
                    
                    Text("Vehicle info")
                    Image(systemName: "chevron.right")
                }
            }.genericRoundedBackgroundShadow(color: .gray)
        }.padding(.horizontal)
    }
}

#Preview {
    DriversList()
}
