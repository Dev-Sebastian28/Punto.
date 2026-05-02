//
//  WelcomeView.swift
//  Punto
//
//  Created by Sebastian Garcia on 3/04/26.
//

import SwiftUI

struct IntroductionAppView: View {
    @Environment(AppCoordinator.self) var coordinator
    private let backgroundColor: LinearGradient = LinearGradient(
        colors: [.myBlue, .myBlue.opacity(0.4), .blue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    headerSection
                    overviewCard
                    visualSection
                    featureGrid
                    footerCard
                }
            }.padding(.horizontal)
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Welcome to Punto")
                        .font(.title).bold()
                        .foregroundStyle(.white)
                    
                    Text("Manage your fleet, organize your operation, and find new transport opportunities all from a single app.")
                        .font(.system(.title3, design: .rounded, weight: .medium))
                        .foregroundStyle(.black)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Button {
                    coordinator.onBoardingCoordinator.navigate(to: .createAccount)
                } label: {
                    Text("Next")
                        .font(.title2).bold()
                        .foregroundStyle(.blue)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(30)
                }
            }
            
            HStack(spacing: 5) {
                welcomeBadge(
                    title: "Fleets",
                    systemImage: "truck.box.fill"
                )
                welcomeBadge(
                    title: "Maintenance",
                    systemImage: "wrench.and.screwdriver.fill"
                )
                welcomeBadge(
                    title: "Income",
                    systemImage: "banknote.fill"
                )
            }
        }
    }
    
    private var overviewCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("What you can do in Punto")
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundStyle(.black)
            
            Text("Punto is an app to manage vehicle transport fleets. You can add tasks, register protocols, control expenses and earnings, track maintenance, and above all, find jobs to keep your operation moving.")
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)
                .padding(.bottom)
            
            HStack(spacing: 12) {
                statPill(title: "Everything in order", value: "Operation")
                statPill(title: "Always visible", value: "Your Fleet")
            }
        }.genericRoundedBackground(color: .white)
    }
    
    private var visualSection: some View {

            
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Your Control Center")
                            .font(.system(.title3, design: .rounded, weight: .bold))
                        
                        Text("Vehicles, drivers, routes, and finances connected in a single view.")
                            .font(.system(.subheadline, design: .rounded, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                }
            }.genericRoundedBackground(color: .white)
        }
    
    private var featureGrid: some View {
        VStack(spacing: 14) {
            HStack(spacing: 14) {
                featureCard(
                    title: "Tasks & Protocols",
                    description: "Organize pending tasks, deliveries, inspections, and key processes for each vehicle.",
                    systemImage: "checklist.checked",
                    tint: .blue
                )
                
                featureCard(
                    title: "Expenses & Earnings",
                    description: "Track fuel, tolls, charges, and transactions to understand your profitability.",
                    systemImage: "dollarsign.arrow.circlepath",
                    tint: .green
                )
            }
            
            HStack(spacing: 14) {
                featureCard(
                    title: "Maintenance",
                    description: "Track services, mileage, and critical parts before they fail.",
                    systemImage: "gearshape.2.fill",
                    tint: .gray
                )
                
                featureCard(
                    title: "Find Jobs",
                    description: "Find new transport opportunities and move your business with more continuity.",
                    systemImage: "magnifyingglass.circle.fill",
                    tint: .yellow
                )
            }
        }
    }
    
    private var footerCard: some View {
        HStack(alignment: .center, spacing: 14) {
            Image(systemName: "road.lanes.curved.right")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
                .genericRoundedBackground(color: .gray)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Start with Clarity")
                    .font(.title3).bold()
                
                Text("Punto helps you understand what's happening with your fleet today and prepare for the next job with more control.")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }.genericRoundedBackground(color: .white)
    }
    
    private func welcomeBadge(title: String, systemImage: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
            Text(title)
                .fontWeight(.semibold)
        }
        .font(.system(.subheadline, design: .rounded))
        .foregroundStyle(.white)
        .genericCapsuleBackground(color: .white.opacity(0.1))
    }
    
    private func statPill(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundStyle(.black)
        }.genericRoundedBackground(color: .gray.opacity(0.24))
    }
    
    private func featureCard(title: String, description: String, systemImage: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundStyle(tint)
                    .genericRoundedBackground(color: tint.opacity(0.1))
                
                Text(title)
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundStyle(.black)
            }
            
            Text(description)
                .font(.system(.footnote, design: .rounded, weight: .medium))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }.genericRoundedBackground(color: .white)
    }
}

#Preview {
    IntroductionAppView()
        .environment(AppCoordinator(appState: AppState()))
}
