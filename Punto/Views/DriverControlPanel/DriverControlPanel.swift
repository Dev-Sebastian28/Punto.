//
//  DriverControlPanel.swift
//  Punto
//
//  Created by Sebastian Garcia on 29/03/26.
//

import SwiftUI

struct DriverControlPanel: View {
    @State private var showHeader: Bool = true
   
    var body: some View {
        VStack(alignment: .center) {
            header
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Quick Actions:")
                    .foregroundStyle(.gray)
                HStack {
                    QuickActionButtonView(image: "", name: "Fuel", color: .brandAmber)
                    QuickActionButtonView(image: "", name: "Phone", color: .brandAmber)
                    QuickActionButtonView(image: "", name: "Alert", color: .brandAmber)
                }
                
                HStack {
                    QuickActionButtonView(image: "", name: "Scaner", color: .brandAmber)
                    QuickActionButtonView(image: "", name: "Hotel", color: .brandAmber)
                    QuickActionButtonView(image: "", name: "Chat", color: .brandAmber)
                }
            }
            .padding(.bottom)
            
            ScrollView(.vertical) {
                    
                QuickInfoCard(titleCard: "Tasks", imageCard: "list.bullet", itemsNumber: 10, color: .blue)
                QuickInfoCard(titleCard: "Expeneses", imageCard: "tag", itemsNumber: 10, color: .green)
                QuickInfoCard(titleCard: "Protocols", imageCard: "shield", itemsNumber: 10, color: .yellow)
                QuickInfoCard(titleCard: "Maintenances", imageCard: "wrench", itemsNumber: 10, color: .blue)
                
            }.ignoresSafeArea(edges: .top)
            .padding(.horizontal, 6)
            .padding(.vertical, 6)
        }
    }
    
    var header: some View {
        VStack(spacing: 2) {
            HStack(alignment: .top) {
                
                if showHeader {
                    HStack(alignment: .bottom, spacing: 20) {
                        
                        HStack(alignment: .bottom, spacing: 10) {
                            Text("Volvo X900x")
                                .font(.title.bold())
                            
                            Text("Plate")
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 1) {
                            Image(systemName: "location.fill")
                            Text("Ver Ruta")
                        }
                        .foregroundStyle(.blue)
                        .bold()
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                } else {
                    
                    Image("volvo")
                        .resizable()
                        .frame(width: 200, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    VStack (alignment: .leading, spacing: 0) {
                        
                        Image(systemName: "")
                        
                        Text("Volvo X900x")
                            .font(.title.bold())
                        Text("Plate")
                            .foregroundStyle(.gray)
                            .font(.title3)
                        
                        HStack(spacing: 0) {
                            Image(systemName: "location.fill")
                            Text("Ver Ruta")
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding(.top, 54)
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .blue, radius: 1)
            
            Button {
                withAnimation {
                    showHeader.toggle()
                }
            }
            
            label: {
                Image(systemName: "chevron.down")
                    .font(.title.bold())
            }
        }
    }
}

struct QuickActionButtonView: View {
    var image: String
    var name: String
    var color: Color
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .padding()
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(name)
                .bold()
        }
        .padding(.horizontal, 45)
        .padding(.vertical, 15)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 1.5)
        
    }
}




#Preview {
    DriverControlPanel()
}
