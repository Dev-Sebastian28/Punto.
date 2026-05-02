//
//  TaskView.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

@Observable
final class TaskState {
    var selectedVehicleIndex: Int = 0
}

struct TaskView: View {
    @State private var isPresentingSheet = false
    @State private var tasksListVM: TaskListViewModel
    @State private var taskVM: TaskViewModel
    @State private var indexState: TaskState
    @State private var selectedTask: VTask?
    @State private var taskIndex: Int = 0
    
    
    init(user: User) {
        let state = TaskState()
        _indexState = State(initialValue: state)
        _tasksListVM = State(wrappedValue: TaskListViewModel(user: user, state: state))
        _taskVM = State(wrappedValue: TaskViewModel(user: user, state: state))
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                if !tasksListVM.hasVehicles {
                    ContentUnavailableView(
                        "No Vehicles added yet",
                        systemImage: "car.fill",
                        description: Text("Add a vehicle to get started.")
                    )
                } else {
                    HeaderComp(
                        title: "Tasks",
                        image: "line.3.horizontal",
                        description: "Manage your vehicles tasks and keep track of them in real time ",
                        color: .blue,
                        gradient: .none
                    )
                    
                    CarouselComp(
                        strategy: TaskAlgorithm(),
                        color: .blue,
                        selectedIndex: $indexState.selectedVehicleIndex,
                    )
                    
                    SelectedInfoComp(
                        model: tasksListVM.selectedVehicleBrandModel,
                        plate: tasksListVM.selectedVehiclePlate,
                        total: tasksListVM.selectedtotalTasks
                    )
                    taskListSection
                }
            }.padding(.horizontal)
            addTaskButton
            
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $isPresentingSheet) {
            AddTaskView(vm: taskVM)
        }
        .sheet(item: $selectedTask) { task in
            TaskDetailView(task: task, vm: taskVM, index: taskIndex)
        }
    }
    private var taskListSection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 10) {
                ForEach(tasksListVM.Tasks.enumerated(), id: \.element.id) { index, task in
                    Button {
                        selectedTask = task
                        self.taskIndex = index
                    } label: {
                        TaskCardView(task: task)
                            .padding(2)
                    }.buttonStyle(.plain)
                }
            }
        }
    }
    private var addTaskButton: some View {
        Button {
            isPresentingSheet.toggle()
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

#Preview {
    let user = User.mock
    TaskView(user: user)
        .environment(CarouselViewModel(user: user))
}
