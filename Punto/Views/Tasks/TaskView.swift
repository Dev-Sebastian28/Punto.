//
//  TaskView.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct TaskView: View {
    @State var vm: TaskListViewModel = .init(userModel: .init(name: "", email: "", access: .admin, country: .argentina), selectedVehicle: 0)
    @State private var isPresentingAddTask: Bool = false

    enum Constants {
        static let textString = "Tasks" // Localization
    }
       
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack (alignment: .leading, spacing: 1) {
                
                Header(title: "Tasks", image: "line.3.horizontal", description: "Welcome to the tasks section. Here you can see the tasks of your vehicles. You can also add new tasks here.", color: .blue, gradient: .none)
                
                CarouselView(algorithm: TasklAlgorithm(), color: .blue, selectedIndex: $vm.selectedVehicle, vehicles: vm.vehicles)
                
                selectedVehicleInfo
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 10) {
                        ForEach(vm.vehicles[vm.selectedVehicle].tasks, id: \.id) { task in
                            TaskCardView(task: task)
                                .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .bottom)),
                                                      removal: .opacity))
                        }
                    }.padding(.top, 10)
                }.animation(.spring(response: 0.4, dampingFraction: 0.8), value: vm.selectedVehicle)
            }.padding(.horizontal, 7)
            
            // Add Task Button
            Button {
                isPresentingAddTask.toggle()
            } label: {
                ButtonView()
            }

            
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $isPresentingAddTask) {
            AddTaskView(tasks: $vm.userModel.vehicles[vm.selectedVehicle].tasks)
        }
    }
    
    @ViewBuilder
    var selectedVehicleInfo: some View {
        Text(vm.selectedVehicleModel)
            .font(.title2.bold())
        
        HStack {
            Text(vm.selectedVehiclePlate)
                .font(.callout)
                .foregroundStyle(.gray)
            
            Spacer()
            
            Text("\(vm.totalTasks) Total")
                .font(.default).bold()
                .foregroundStyle(.gray)
        }
    }
}

private struct ButtonView: View {
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.headline.weight(.bold))
                Text("Add Task")
                    .font(.headline.weight(.semibold))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .foregroundStyle(.white)
            .background(
                LinearGradient(colors: [.blue, Color.blue.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(Capsule())
            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 6)
        }
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
}



#Preview {
    TaskView()
}
