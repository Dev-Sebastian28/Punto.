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
    
    @State private var state: ExpensesState
    @State private var vm : ExpensesViewModel
    @State private var listVM: ExpenseListViewModel
    @State private var expenseVM: ExpenseViewModel
    
    init(user: User) {
        let state = ExpensesState()
        _state = State(wrappedValue: state)
        _vm = State(wrappedValue: ExpensesViewModel(user: user, state: state))
        _listVM = State(wrappedValue: ExpenseListViewModel(user: user, state: state))
        _expenseVM = State(wrappedValue: ExpenseViewModel(user: user, state: state))
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
                entriesList
                
            }
            .padding(.horizontal, 8)
            .onChange(of: state.selectedIndex) { _, _ in
                listVM.reset()
            }
            
            if isPresentedFilter {
                ExpenseFilterView(
                    isPresented: $isPresentedFilter,
                    strategy: $listVM.strategy,
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
                    vm: expenseVM
                ).presentationDetents([.height(330)])
            }
        }
    }
    
    private var controlView: some View {
        HStack {
            
            TextFieldComp(text: $state.search, prompt: "Search for", leadingIcon: "magnifyingglass")
            
            // Filter Button
            ControlButton(iconName: "slider.vertical.3") {
                isPresentedFilter.toggle()
            }
        }.bold()
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
