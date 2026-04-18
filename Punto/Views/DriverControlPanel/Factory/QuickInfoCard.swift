//
//  QuickInfoCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 23/03/26.
//
import SwiftUI

// MARK: - Protocols

protocol FactoryQuickInfoCard {
    associatedtype Content: View
    func make() -> Content
}

struct QuickSummary {
    let title: String
    let value: Int
    let color: Color
}

// MARK: - Generic Card View

struct QuickInfoCard<Item: Identifiable>: View {
    let title: String
    let icon: String
    let iconColor: Color
    let items: [Item]
    let quickInfo: [QuickSummary]
    let rowContent: (Item) -> AnyView

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            headerView
            Divider()
            ForEach(Array(items.prefix(3))) { item in
                rowContent(item)
            }
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 9)
                .stroke(.bar, lineWidth: 2)
        }
    }

    // MARK: Header

    private var headerView: some View {
        HStack(alignment: .top) {
            HStack(alignment: .top, spacing: 8) {
                iconView
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.title2.bold())
                    Text("\(items.count) items")
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
            HStack(alignment: .top) {
                ForEach(quickInfo, id: \.title) { info in
                    QuickSummaryBadge(info: info)
                }
            }
        }
    }

    private var iconView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 55, height: 55)
                .foregroundStyle(iconColor.opacity(0.3))
            Circle()
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
            Image(systemName: icon)
                .font(.title3.bold())
                .foregroundStyle(iconColor)
        }
    }
}

// MARK: - Quick Summary Badge

struct QuickSummaryBadge: View {
    let info: QuickSummary
    var body: some View {
        VStack {
            Text(info.title)
                .foregroundStyle(info.color)
            Text("\(info.value)")
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(info.color)
                .fill(info.color.opacity(0.1))
        )
    }
}
