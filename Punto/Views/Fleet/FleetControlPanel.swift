//
//  FleetControlPanel.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//

import SwiftUI

struct FleetControlPanel: View {
    @State private var hideHeader: Bool = false
    @State private var searchText: String = ""
    let vm: FleetViewModel
    private let gradient: LinearGradient = LinearGradient(
        colors: [Color.brandBlue, Color.brandBlueDark,Color.brandBlue],
        startPoint: .center,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if hideHeader {
                header
                
            } else {
                header
                infScroll
                balanceSection
                searchBarSection
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .padding(.top, 54)
        .padding(.bottom, 12)
        .background(
            gradient
        )
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 28,
                bottomTrailingRadius: 28,
                topTrailingRadius: 0
            )
        ).shadow(color: Color.brandBlueDark.opacity(0.2), radius: 12, x: 0, y: 8)
    }
    
    private var header: some View {
        HStack(alignment: .center) {
            Text("Fleet")
            
            Spacer()
            
            Button {
             hideHeader.toggle()
                
            } label: {
                Image(systemName: hideHeader ? "chevron.down" : "chevron.up")
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text(vm.vehiclesCount + " vehicles")
                    .bold()
                Text("under control")
            }.font(.subheadline.weight(.regular))
        }.font(.largeTitle.bold())
    }
    
    private var infScroll: some View  {
        ScrollView(.horizontal) {
            HStack {
                summaryCard(.init(
                    title: "Actives",
                    value: "\(vm.activeVehiclesCount)",
                    icon: "car.side.hill.up")
                )
                
                summaryCard(.init(
                    title: "Inactives",
                    value: "\(vm.inactiveVehiclesCount)",
                    icon: "car.window.right.xmark")
                )
                
                summaryCard(.init(
                    title: "Maintena.",
                    value: "\(vm.manteinicesCount)",
                    icon: "menucard.fill")
                )
            }
        }
    }
    
    private var balanceSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Total Balance")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.white.opacity(0.78))
                Text(vm.totalBalance)
                    .font(.title.bold())
            }
            Spacer()
            
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.title2.bold())
        }.genericRoundedBackground(color: .white.opacity(0.14))
    }
    
    @ViewBuilder
    private var searchBarSection: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.brandBlue)
            
            TextField(
                "Search vehicle, plate or driver",
                text: $searchText
            ).textFieldStyle(.plain)
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.textMuted)
                }.buttonStyle(.plain)
            }
        }.genericCapsuleBackground(color: .white)
        
    }
    
    private func summaryCard(_ item: FleetSummaryItem) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(alignment: .center, spacing: 12) {
                Text(item.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.white.opacity(0.78))
                
                Image(systemName: item.icon)
                    .font(.caption.weight(.bold))
                    .padding(6)
                    .background(Color.white.opacity(0.15))
                    .clipShape(.circle)
            }
            Text(item.value)
                .font(.title2.bold())
        }.genericRoundedBackground(color: .white.opacity(0.14))
    }
}

private struct FleetSummaryItem {
    let title: String
    let value: String
    let icon: String
}

#Preview {
    FleetControlPanel(vm: FleetViewModel(appState: AppState()))
    
}
