//
//  ExpensesView.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct ExpensesView: View {
    @State private var isPresentedAddExpense: Bool = false
    @State private var isPresentedFilter: Bool = false
    @State private var search: String = ""
    @State private var vm = ExpensesViewModel(
        userModel: .init(name: "", email: "", access: .admin, country: .argentina),
        selectedVehicle: 0
    )
    private let primaryGreen = Color.green.mix(with: .teal, by: 0.25)
    private let accentGreen = Color.green.mix(with: .mint, by: 0.35)
    
    var body: some View {
        @Bindable var bindableVM = vm
        
        ZStack {
            VStack (alignment: .leading) {
                // Header
                titleHeader
                
                // Search view, filter button and squeres
                controlView
                
                // Over View Card
                ExpenseOverviewCard(balance: vm.balance, profit: vm.profit, losses: vm.losses)
                
                information
                                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    ForEach(vm.filteredCollection, id: \.id) { expense in
                        ExpenseCardView(expense: expense)
                            .animation(.easeOut, value: isPresentedFilter)
                    }
                }
            }.padding(.horizontal, 4)
            
            if isPresentedFilter {
                VStack {
                    ExpenseFilterView(
                        isPresented: $isPresentedFilter,
                        basedCollection: vm.expenses,
                        filterCollection: $bindableVM.filteredCollection
                    )
                    .padding(.vertical, 120)
                    Spacer()
                }.animation(.easeOut, value: isPresentedFilter)
            }
            
            // Circle Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        isPresentedAddExpense.toggle()
                    } label: {
                        Circle()
                            .frame(width: 56, height: 56)
                            .foregroundStyle(LinearGradient(colors: [primaryGreen, accentGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                    }.padding()
                }
            }
            .sheet(isPresented: $isPresentedAddExpense) {
                AddExpenseView(collection: expensesBinding, isPresented: $isPresentedAddExpense)
                    .presentationDetents([.height(390)])
                    .onDisappear {
                        vm.resetFilters()
                    }
            }
        }.ignoresSafeArea(edges: .bottom)
    }
    var titleHeader: some View {
        VStack(alignment: .leading, spacing: -5) {
            Text("Expenses")
                .font(.largeTitle.bold())
                .foregroundStyle(LinearGradient(colors: [primaryGreen, accentGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            Text("Expenses of Volvo x900x")
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
    
    var controlView: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                    .padding(.leading)
                TextField("", text: $search, prompt: Text("Search").foregroundStyle(.black).bold())
            }
            .frame(height: 44)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            // Filter Button
            Button {
                withAnimation {isPresentedFilter.toggle()}
            } label: {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 50, height: 44)
                    .foregroundStyle(LinearGradient(colors: [primaryGreen, accentGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay {
                        Image(systemName: "slider.vertical.3")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .rotationEffect(.degrees(90.0))
                    }
                
            }
            
            // Over view button
            Button {
                // Show overview
            } label: {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 50, height: 44)
                    .foregroundStyle(LinearGradient(colors: [primaryGreen, accentGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay {
                        Image(systemName: "square.split.2x2.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
            }
        }
    }
    
    var information: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Transactions")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Text("\(vm.totalExpenses) Total")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            
            Text("Today")
                .font(.headline)
                .foregroundStyle(.gray)
            
            Separator()
                .padding(.horizontal, 5)

        }
    }
    
    private var expensesBinding: Binding<[Expense]> {
        Binding(
            get: { vm.expenses },
            set: { vm.updateExpenses($0) }
        )
    }
}

#Preview {
    ExpensesView()
}
