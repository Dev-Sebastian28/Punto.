//
//  TaskView.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct TaskView: View {
    @State private var vm: TaskListViewModel
    @State private var isPresentingAddTask = false


    init(user: User) {
        _vm = State(wrappedValue: TaskListViewModel(user: user, selectedVehicle: 0))
    }
 
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                Header(
                    title: "Tasks",
                    image: "line.3.horizontal",
                    description: "Gestiona las tareas de tus vehículos y agrega nuevas desde aquí.",
                    color: .blue,
                    gradient: .none
                )

                if vm.vehicles.isEmpty {
                    ContentUnavailableView(
                        "Sin vehículos",
                        systemImage: "car.fill",
                        description: Text("Agrega un vehículo para ver sus tareas.")
                    )
                } else {
                    CarouselView(
                        algorithm: TasklAlgorithm(),
                        color: .blue,
                        selectedIndex: $vm.selectedVehicle
                    )

                    vehicleInfoSection

                    taskListSection
                }
            }
            .padding(.horizontal, 7)

            addTaskButton
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $isPresentingAddTask) {
            AddTaskView(tasks: .constant([]))
        }
        .onAppear {
         //   print(vm.)
        }
    }
}

// MARK: - Subviews
private extension TaskView {

    var vehicleInfoSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(vm.selectedVehicleModel)
                .font(.title2.bold())

            HStack {
                Text(vm.selectedVehiclePlate)
                    .font(.callout)
                    .foregroundStyle(.gray)

                Spacer()

                Text("\(vm.totalTasks) Total")
                    .font(.callout).bold()
                    .foregroundStyle(.gray)
            }
        }
    }

    var taskListSection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 10) {
                ForEach(vm.vehicles[vm.selectedVehicle].tasks, id: \.id) { task in
                    TaskCardView(task: task)
                        .padding(2)
                }
            }
        }
    }

    var addTaskButton: some View {
        Button {
            isPresentingAddTask.toggle()
        } label: {
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
                LinearGradient(colors: [.blue, .blue.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(Capsule())
            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 6)
        }
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
}

// MARK: - Preview
#Preview {
    let user = User.mock
    TaskView(user: user)
        .environment(CarouselViewModel(user: user))
}
