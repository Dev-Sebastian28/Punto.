//
//  SectionView.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/05/26.
//
import SwiftUI

// MARK: - SECTION ITEM MODEL
struct SectionItem: Hashable {
    let icon: String
    let title: String
    let route: ProfileRoute
}


// MARK: - SECTION VIEW
struct SectionView: View {
    var coordinator: ProfileCoordinator
    var title: String
    var items: [SectionItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            VStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                    
                    Button {
                        coordinator.navigate(to: item.route)
                    } label: {
                        HStack {
                            Image(systemName: item.icon)
                            Text(item.title)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }.padding()
                    }.buttonStyle(.plain)
                    
                    if item != items.last {
                        Divider()
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal)
        }
    }
}
