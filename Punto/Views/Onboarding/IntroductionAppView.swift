//
//  WelcomeView.swift
//  Punto
//
//  Created by Sebastian Garcia on 3/04/26.
//

import SwiftUI

struct IntroductionAppView: View {
    @Environment(AppCoordinator.self) var coordinator

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.myBlue, .myBlue.opacity(0.4), .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    headerSection
                    overviewCard
                    visualSection
                    featureGrid
                    footerCard
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 28)
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Welcome to Punto")
                        .font(.title).bold()
                        .foregroundStyle(.white)
                    
                    Text("Manage your fleet, organize your operation, and find new transport opportunities all from a single app.")
                        .font(.system(.title3, design: .rounded, weight: .medium))
                        .foregroundStyle(.black)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Button {
                    coordinator.onBoardingCoordinator.navigate(to: .form1)
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
        VStack(alignment: .leading, spacing: 14) {
            Text("What you can do in Punto")
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundStyle(Color(red: 0.09, green: 0.19, blue: 0.22))
            
            Text("Punto is an app to manage vehicle transport fleets. You can add tasks, register protocols, control expenses and earnings, track maintenance, and above all, find jobs to keep your operation moving.")
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack(spacing: 12) {
                statPill(title: "Everything in order", value: "Operation")
                statPill(title: "Always visible", value: "Your Fleet")
            }
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.black.opacity(0.10), radius: 18, x: 0, y: 12)
    }
    
    private var visualSection: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
            
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
                
                Image("transportation")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                
            }
            .padding(18)
        }
        .frame(minHeight: 200)
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
                    tint: .blue
                )
            }
            
            HStack(spacing: 14) {
                featureCard(
                    title: "Maintenance",
                    description: "Track services, mileage, and critical parts before they fail.",
                    systemImage: "gearshape.2.fill",
                    tint: Color(red: 0.17, green: 0.53, blue: 0.83)
                )
                
                featureCard(
                    title: "Find Jobs",
                    description: "Find new transport opportunities and move your business with more continuity.",
                    systemImage: "magnifyingglass.circle.fill",
                    tint: Color(red: 0.46, green: 0.38, blue: 0.86)
                )
            }
        }
    }
    
    private var footerCard: some View {
        HStack(alignment: .center, spacing: 14) {
            Image(systemName: "road.lanes.curved.right")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Start with Clarity")
                    .font(.system(.headline, design: .rounded, weight: .bold))
                
                Text("Punto helps you understand what's happening with your fleet today and prepare for the next job with more control.")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(20)
        .background(.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 16, x: 0, y: 8)
    }
    
    private func welcomeBadge(title: String, systemImage: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
            Text(title)
                .fontWeight(.semibold)
        }
        .font(.system(.subheadline, design: .rounded))
        .foregroundStyle(.white)
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.white.opacity(0.10))
        .clipShape(Capsule())
    }
    
    private func statPill(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundStyle(Color(red: 0.09, green: 0.19, blue: 0.22))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(.black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
    
    private func featureCard(title: String, description: String, systemImage: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(tint)
                .frame(width: 52, height: 52)
                .background(tint.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
            Text(title)
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundStyle(Color(red: 0.09, green: 0.19, blue: 0.22))
            
            Text(description)
                .font(.system(.footnote, design: .rounded, weight: .medium))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 190, alignment: .topLeading)
        .padding(18)
        .background(.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 14, x: 0, y: 8)
    }
}

#Preview {
    IntroductionAppView()
        .environment(OnboardingCoordinator(appState: AppState()))
}
