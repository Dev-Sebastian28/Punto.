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
    @State private var isInfoPresented: Bool = false
    
    @State private var state: ExpensesState
    @State private var vm : ExpensesViewModel
    @State private var listVM: ExpenseListViewModel
    
    init(user: User) {
        let state = ExpensesState()
        _state = State(wrappedValue: state)
        _vm = State(wrappedValue: ExpensesViewModel(user: user, state: state))
        _listVM = State(wrappedValue: ExpenseListViewModel(user: user, state: state))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack (alignment: .leading, spacing: 15) {
                HeaderComp(
                    title: "Expenses",
                    image: "dollarsign.circle",
                    description: "Welcome to your expenses, track your vehicles expenses and see your balance",
                    color: .green,
                    gradient: viewStyle
                )
                
                CarouselComp(
                    strategy: ExpenseAlgorithm(),
                    color: .green,
                    selectedIndex: $state.selectedIndex,
                )
                
                controlView
                
                if isInfoPresented {
                    information
                }
                
                entriesList
                
            }
            .padding(.horizontal, 8)
            .onChange(of: state.selectedIndex) { _, _ in
                listVM.reset()
            }
            
            if isPresentedFilter {
                ExpenseFilterView(
                    isPresented: $isPresentedFilter,
                    strategy: $listVM.strategy
                ).transition(.move(edge: .top))
            }
            VStack {
                Spacer()
                ControlButton(iconName: "plus", isCircular: true) {
                    isPresentedAddExpe.toggle()
                }
            }
            .padding()
            .sheet(isPresented: $isPresentedAddExpe) {
                AddExpenseView(
                    collection: .constant([]),
                    isPresented: $isPresentedAddExpe
                ).presentationDetents([.height(390)])
            }
        }.ignoresSafeArea(edges: .bottom)
    }
    
    private var controlView: some View {
        HStack {
            
            TextFieldComp(text: $state.search, prompt: "Search for", image: "magnifyingglass")
            
            // Filter Button
            ControlButton(iconName: "slider.vertical.3") {
                isPresentedFilter.toggle()
            }
            
            // Over view button
            ControlButton(iconName: "square.split.2x2.fill") {
                isInfoPresented.toggle()
            }
        }.bold()
    }
    private var information: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Balance
            HStack(spacing: 6) {
                Label("Balance:", systemImage: "wallet.pass.fill")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text(vm.balance)
                    .font(.title3.bold())
                    .foregroundStyle(.green)
                
            }.customBackground(color: .white)
            
            HStack {
                // Incomes
                HStack(spacing: 6) {
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundStyle(.blue)
                        .font(.title2)
                    
                    Text(vm.losses)
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
                    Text(vm.profit)
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
                .foregroundStyle(viewStyle).opacity(0.2)
        }
    }
    private var entriesList: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(listVM.filteredExpenses, id: \.id) { expense in
                ExpenseCardView(expense: expense)
                    .padding(.horizontal, 2)
                    .animation(.easeOut, value: isPresentedFilter)
            }
        }
    }
    private var viewStyle: LinearGradient {
        LinearGradient(colors: [
            .green.opacity(0.8),
            .brandGreenDark,
            .brandGreen
        ], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
private struct ControlButton: View {
    let viewStyle =  LinearGradient(colors: [
        .green.opacity(0.8),
        .brandGreenDark,
        .brandGreen
    ], startPoint: .topLeading, endPoint: .bottomTrailing)
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
                        .foregroundStyle(viewStyle)                )
        }
    }
}



#Preview {
    let user = User.mock
    ExpensesView(user: user)
        .environment(CarouselViewModel(user: user))
    
}
