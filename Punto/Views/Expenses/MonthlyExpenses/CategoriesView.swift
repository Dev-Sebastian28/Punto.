//
//  CategoriesView.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//

import SwiftUI

struct Category {
    var title: String
    var amount: String
    var color: Color
    var porcent: Double
    var image: String
}

struct CategoriesView: View {
    let categories: [Category]
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            title
            
            ForEach(categories, id: \.title) { category in
                categoryCard(category)
            }
        }
        .padding()
        .background(
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .gray.opacity(0.6),radius: 1.5)
        )
    }
    private var title: some View {
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
    }
    private func  categoryCard(_ category: Category) -> some View {
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
    CategoriesView(categories: [])
}
