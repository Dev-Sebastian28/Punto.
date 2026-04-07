//
//  MaintenanceCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/03/26.
//

import SwiftUI

struct MaintenanceCard: View {
    @State var maintainablePart: MaintainableComponent

    private var usefulLifeText: String {
        "\(maintainablePart.rangeOfUsefulLife) km"
    }

    private var maintenanceDateText: String {
        maintainablePart.lastTimeMaintainedInformation.0.formatted(date: .abbreviated, time: .omitted)
    }

    private var nextReviewDateText: String {
        maintainablePart.rangeDateOfUsefulLife.upperBound.formatted(date: .abbreviated, time: .omitted)
    }

    var body: some View {
        VStack(spacing: 10) {
            headerSection

            Divider()
                .padding(.horizontal, 5)

            metricsSection

            Divider()
                .padding(.horizontal, 5)

            progressSection
        }
        .padding(.horizontal, 13)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private extension MaintenanceCard {
    var headerSection: some View {
        HStack(spacing: 10) {
            Image(systemName: "engine.combustion.badge.exclamationmark.fill")
                .font(.title2)

            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 10) {
                    Text(maintainablePart.componentName)
                        .font(.title2.bold())

                    Spacer()

                    StatusBadge(text: "Critical", color: .red)
                }

                HStack {
                    Text("Useful Life:")
                        .foregroundStyle(.black.opacity(0.8))

                    Text(usefulLifeText)
                        .foregroundStyle(.gray)
                }
                .font(.caption)
            }
        }
    }

    var metricsSection: some View {
        HStack {
            infoPill(title: "Last Service", value: maintenanceDateText)

            Spacer()

            Text("-")
                .font(.largeTitle.bold())

            Spacer()

            infoPill(title: "Next Review", value: nextReviewDateText)
        }
    }

    var progressSection: some View {
        VStack {
            ProgressView(value: 1.0) {
                HStack(spacing: 5) {
                    Text("Wear Progress")
                    Text("100%")
                        .bold()
                }
                .font(.caption)
                .foregroundStyle(.gray)
            }

            HStack {
                Text(maintenanceDateText)

                Spacer()

                Text(nextReviewDateText)
            }
            .font(.caption)
            .foregroundStyle(.gray)
            .bold()
        }
        .progressViewStyle(.linear)
        .padding(.vertical, 6)
    }

    func infoPill(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(.caption.bold())

            HStack {
                Image(systemName: "info.circle")
                Text(value)
                    .font(.footnote)
            }
            .foregroundStyle(.blue)
            .bold()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.25))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


private struct StatusBadge: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text.capitalized)
            .font(.subheadline.bold())
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.35))
            .clipShape(Capsule())
    }
}




//#Preview {
//    MaintenanceCard(maintainablePart: MaintainableComponent(componentName: "Oil Filter", lastTimeMaintainedInformation: (Date().addingTimeInterval(-30000), 35000), rangeOfUsefulLife: 5000...8000, rangeDateOfUsefulLife: Date()...Date()))
//}
