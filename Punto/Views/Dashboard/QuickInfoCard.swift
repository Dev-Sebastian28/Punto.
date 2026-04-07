//
//  QuickInfoCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 23/03/26.
//
import SwiftUI

struct QuickSummary {
    var title1: String
    var value1: Int
    var title2: String
    var value2: Int
    var title3: String
    var value3: Int
}

struct QuickInfoItem: Identifiable {
    let id: Int
    let title: String
    let description: String?
    let value: Int?
    let date: Date?
    let classification: Classification?
    let color: Color
    
    enum Classification: String, CaseIterable {
        case low
        case medium
        case high
    }
}

struct QuickInfoCard: View {
    var titleCard: String
    var imageCard: String
    var itemsNumber: Int
    var color: Color
    var quick: QuickSummary?
    var collection: [QuickInfoItem] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            
            title
            
            Separator()
            
            ForEach(collection, id: \.id) { inf in
                quickCollection(inf)
            }
            
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 9)
                .stroke(color, lineWidth: 2)
        }
    }
    
    var title: some View {
        HStack {
            HStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 65,  height: 65)
                    .foregroundStyle(color.opacity(0.3))
                    .overlay {
                        Image(systemName: imageCard)
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .padding(13)
                            .background {
                                color
                                    .clipShape(.circle)
                            }
                    }
                
                VStack (alignment: .leading, spacing: 0) {
                    Text(titleCard)
                        .font(.title.bold())
                    Text("\(itemsNumber.description)" + " items")
                        .foregroundStyle(Color.gray)
                }
            }
            
            // Quick Information
            if let quick {
                HStack {
                    
                    quickInformation(title: quick.title1, value: quick.value1, color: .orange)
                    quickInformation(title: quick.title2, value: quick.value2, color: .green)
                    if !quick.title3.isEmpty {
                        quickInformation(title: quick.title3, value: quick.value3, color: .gray)
                    }
                }
                .padding(.leading, 20)
                .foregroundStyle(Color.white)
                .bold()
            }
            
            
        }
    }
}

private func quickInformation(title: String, value: Int, color: Color) -> some View {
    VStack {
        Text(title)
            .padding(.vertical, 3)
            .padding(.horizontal, 10)
            .background {
                color
                    .clipShape(.capsule)
            }
        Text("\(value)")
            .foregroundStyle(.gray)
    }
}

private func quickCollection(_ inf: QuickInfoItem) -> some View {
    VStack(alignment: .leading, spacing: 0) {
        
        HStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 10, height: 20)
                .foregroundStyle(inf.color)
            Text(inf.title)
                .font(.title3.bold())
            
            Spacer()
            
            if let clas = inf.classification {
                Text(clas.rawValue.capitalized)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 2)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Capsule())
            }
            
            if let date = inf.date {
                Text(date.formatted(.dateTime.day().hour()))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 2)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Capsule())
            }
            
            if let val = inf.value {
                Text("\(val)")
            }
        }
        if let desc = inf.description {
            Text(desc)
                .font(.subheadline)
                .foregroundStyle(Color(.secondaryLabel))
        }
    }
}
    
    #Preview {
        QuickInfoCard(titleCard: "Expeneses", imageCard: "dollarsign.circle.fill", itemsNumber: 6, color: .green, quick: .init(title1: "ToDo", value1: 10, title2: "Done", value2: 4, title3: "", value3: 0), collection: [.init(id: 0, title: "Wash the vehicle", description: "Go to the washcar", value: .none, date: .distantFuture, classification: .high, color: .green)])
    }
