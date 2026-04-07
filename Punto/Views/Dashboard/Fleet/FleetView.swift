//
//  FleetView.swift
//  Punto
//
//  Created by Sebastian Garcia on 23/03/26.
//

import SwiftUI

struct FleetView: View {
    @State private var searchText = ""
    @State private var hideHeader: Bool = false
    @State private var vm = FleetViewModel(user: .init(name: "", email: "", access: .admin, country: .argentina))

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(vm.vehicles, id: \.vehicleInformation.id) { vehicle in
                    FleetVehicleCard(vehicle: vehicle, isActive: true)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 4)
                }
            }
            .padding(.top, 100)

            VStack {
                headerSection
                Spacer()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 10) {
                Text("Fleet")
                    .font(.largeTitle.bold())
                
                Spacer()
                
                Button {
                    withAnimation(.linear(duration: 0.5)) {
                        hideHeader.toggle()
                    }
                } label: {
                    Image(systemName: hideHeader ? "chevron.down" : "chevron.up")
                }.font(.largeTitle.bold())
                
                Spacer()

                VStack(alignment: .leading, spacing: 0) {
                    Text("\(vm.vehiclesCount)" + " vehicles")
                    Text("under control")
                }
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color.white.opacity(0.8))
            }
            
            if hideHeader {
                
            } else {
                quickInf
                balanceCard
                searchBar
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .padding(.top, 54)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color.brandBlue, Color.brandBlueDark,Color.brandBlue],
                startPoint: .center,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 28,
                bottomTrailingRadius: 28,
                topTrailingRadius: 0
            )
        )
        .shadow(color: Color.brandBlueDark.opacity(0.2), radius: 12, x: 0, y: 8)
    }
    
    @ViewBuilder
    private var quickInf: some View {
        if vm.enoughVehiclesToQuickInfo {
            HStack {
                summaryCard(.init(title: "Actives", value: "\(vm.activeVehiclesCount)", icon: ""))
                summaryCard(.init(title: "Inactives", value: "\(vm.inactiveVehiclesCount)", icon: ""))
                summaryCard(.init(title: "Maintena.", value: "\(vm.manteinicesCount)", icon: ""))

                
            }
        } else {
            summaryCard(.init(title: "Maintena.", value: "\(vm.manteinicesCount)", icon: ""))
        }
    }
    
    private var balanceCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Total Balance")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.white.opacity(0.78))
                Text("$" + "\(vm.totalBalance)")
                    .font(.title.bold())
            }
            
            Spacer()
            
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.title2.bold())
                .padding(12)
                .background(Color.white.opacity(0.16))
                .clipShape(.circle)
        }
        .padding(10)
        .background(Color.white.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    @ViewBuilder
    private var searchBar: some View {
        if  vm.enoughVehiclesToQuickInfo {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.brandBlue)
                
                TextField("Search vehicle, plate or driver", text: $searchText)
                    .textFieldStyle(.plain)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.textMuted)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            .background(Color.platformSystemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.brandBlue.opacity(0.18), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
        } else { EmptyView() }
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
        }
        .frame(alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

private struct FleetSummaryItem {
    let title: String
    let value: String
    let icon: String
}

#Preview {
    FleetView()
        .environment(NavigationRouter())
}
