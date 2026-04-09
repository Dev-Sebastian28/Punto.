//
//  ExpensesView.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct ExpensesView: View {
    @State private var isPresentedAddExpe: Bool = false
    @State private var isPresentedFilter: Bool = false
    @State private var search: String = ""
    @State private var filterCollection: [Expense]
    @State private var vm = ExpensesViewModel(userModel: .init(name: "", email: "", access: .admin, country: .argentina),selectedVehicle: 0)
    let colors: [Color] = [.green.opacity(0.8),.brandGreenDark,.brandGreen]
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading, spacing: 5) {
                Header
                controlView
                CarouselView(selectedIndex: .constant(0), quickSummary: [], vehicles: vm.userModel.vehicles, color: .green)
                information
                
                Separator()
                
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach(vm.filteredCollection, id: \.id) { expense in
                        ExpenseCardView(expense: expense)
                            .padding(.top, 2)
                            .padding(.horizontal, 2)
                            .animation(.easeOut, value: isPresentedFilter)
                    }
                }
            }.padding(.horizontal, 8)
            
            VStack(alignment: .trailing) {
                if isPresentedFilter {
                    ExpenseFilterView(isPresented: $isPresentedFilter,basedCollection: vm.expenses,filterCollection: $filterCollection)
                        .transition(.move(edge: .top))
                }
                Spacer()
                
                HStack {
                    Spacer()
                    ControlButton(iconName: "plus", isCircular: true) {
                        
                    }
                }
                .padding()
                .sheet(isPresented: $isPresentedAddExpe) {
                    AddExpenseView(collection: .constant([]), isPresented: $isPresentedAddExpe)
                        .presentationDetents([.height(390)])
                        .onDisappear {
                            vm.resetFilters()
                        }
                }
            }.ignoresSafeArea(edges: .bottom)
        }
    }
    
    @ViewBuilder
    var Header: some View {
        Text("Expenses")
            .font(.system(size: 44, weight: .bold))
            .customGradient()
    }
    
    var controlView: some View {
        HStack {
            TextFieldComponent(text: $search, prompt: "Search for", image: "magnifyingglass")
            
            // Filter Button
            ControlButton(iconName: "slider.vertical.3") {
                isPresentedFilter.toggle()
            }
            
            // Over view button
            ControlButton(iconName: "square.split.2x2.fill") {
                
            }
            
        }.bold()
    }
    
    var information: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Balance
            HStack(spacing: 6) {
                Label("Balance:", systemImage: "wallet.pass.fill")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("$102.000")
                    .font(.title3.bold())
                    .foregroundStyle(.green)
                
            }
            .customBackground(color: .white)
                        
            HStack {
                // Incomes
                HStack(spacing: 6) {
                        Image(systemName: "arrow.down.circle.fill")
                            .foregroundStyle(.blue)
                            .font(.title2)

                    Text("$50.000")
                        .font(.headline.bold())
                        .foregroundStyle(.blue)
                }
                .customBackground(color: .blue.opacity(0.15))
                
                Spacer()
                
                // Losses
                HStack(spacing: 6) {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundStyle(.red)
                            .font(.title2)
                    Text("$20.000")
                        .font(.headline.bold())
                        .foregroundStyle(.red)
                }
                .customBackground(color: .red.opacity(0.35))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .customGradient().opacity(0.2)
        }
    }
    
    init() {
        self.isPresentedAddExpe = false
        self.isPresentedFilter = false
        self.filterCollection = []
    }
}

struct CustomLinearGradient: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(LinearGradient(colors: [
                .green.opacity(0.8),
                .brandGreenDark,
                .brandGreen
            ], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

private struct ControlButton: View {
    let iconName: String
    var isCircular: Bool = false
    let action: () -> Void
    var body: some View {
        Button {
            withAnimation(.linear) {
                action()
            }
        } label: {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundStyle(.white)
                .padding(11)
                .background(
                    RoundedRectangle(cornerRadius: isCircular ? .infinity : 10)
                        .customGradient()
                )
        }
    }
}


#Preview {
    ExpensesView()
}
