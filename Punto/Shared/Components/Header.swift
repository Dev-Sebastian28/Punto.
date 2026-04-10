//
//  Header.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/04/26.
//

import SwiftUI
import Combine

struct Header: View {
    let title: String
    let image: String?
    let description: String?
    let color: Color
    let gradient: LinearGradient? 
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var currentTime = 0
    @State private var timerSubscription: Cancellable?
    @State private var isHide: Bool = false
    
        
    var body: some View {
        
        if currentTime == 4 {
           HStack {
               CommonButton(title: "Go Back", icon: .none,style: .blue) {
                   
               }
               
               Spacer()
    
               CommonButton(title: "Hide Vehicles Section", icon: "chevron.down",style: nil) {
                   
               }
            }
        } else {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(.title).bold()
                        .foregroundStyle(style)
                    
                    if let image {
                        Image(systemName: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(color)
                    }
                }

                 
                if let description {
                    Text(description)
                        .font(.caption).bold()
                        .foregroundStyle(.secondary)
                        .transition(.move(edge: .leading))

                }
            }
            .onReceive(timer) { _ in
                withAnimation(.linear) {
                    if self.currentTime >= 0 && self.currentTime <= 4 {
                        currentTime += 1
                    } else {
                        timerSubscription?.cancel()
                        timerSubscription = nil
                    }
                }
            }.transition(.move(edge: .top))
        }
    }
    
    private var style: AnyShapeStyle {
        if let gradient {
            return AnyShapeStyle(gradient)
        } else {
            return AnyShapeStyle(color)
        }
    }
}


struct CommonButton: View {
    let title: String
    let icon: String?
    let style: Color?
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                HStack {
                    Text(title)
                        .foregroundStyle(style ?? .secondary)
                    if let icon {
                        Image(systemName: icon)
                            .foregroundStyle(style ?? .secondary)
                    }
                }
                    
            }
            .font(.system(size: 15).weight(.semibold))
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(style?.opacity(0.15) ?? .secondary.opacity(0.15))
            )
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        Header(title: "Tasks",
               image: "plus",
               description: "Welcome to task, here you can add and organize your tasks",
               color: .blue,
               gradient: nil)
        
        Header(title: "Premium",
               image: "star.fill",
               description: "Unlock all features",
               color: .purple,
               gradient: LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing))
    }
    .padding()
}
