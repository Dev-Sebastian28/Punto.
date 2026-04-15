//
//  ProtocolForm.swift
//  Punto
//
//  Created by Sebastian Garcia on 7/04/26.
//

import SwiftUI

enum Mode {
    case add
    case edit
}

struct ProtocolDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isPresented: Bool
    @State private var element: VehicleProtocol
    let oldElement: VehicleProtocol
    let mode: Mode
    let index: Int?
    var vm: ProtocolFormsViewModel
    
    private var validation: Bool {
        switch mode {
        case .add:
            return !element.name.isEmpty && !element.tasks.isEmpty
        case .edit:
            return oldElement != element
        }
    }

    init(user: User, index: Int) {
        let emptyProtocol = VehicleProtocol(
            id: .init(),
            name: "",
            description: nil,
            tasks: [],
            importance: .medium,
            time: .daily
        )
        _isPresented = State(initialValue: false)
        _element = State(initialValue: emptyProtocol)
        self.oldElement = emptyProtocol
        self.vm = .init(user: user, selectedVehicleIndex: index)
        self.index = index
        self.mode = .add
    }
    init(user: User, element: VehicleProtocol, index: Int) {
        _isPresented = State(initialValue: false)
        _element = State(initialValue: element)
        self.oldElement = element
        self.vm = .init(user: user, selectedVehicleIndex: index)
        self.index = index
        self.mode = .edit
    }
    
    
    let colors: [Color] = [.green, .yellow, .red]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                header
                nameandDescription
                importanceView
                timeAction
                subTasks
            }.padding(.horizontal)
        }.sheet(isPresented: $isPresented) {
            Sheet(collection: $element.tasks)
                .presentationDetents([.height(200)])

        }
        
        
        VStack {
            
            if mode == .add {
                DButtonComp(
                    text: "Create Protocol",
                    color: .green,
                    image: "plus",
                    isEnabled: validation ) {
                        vm.addProtocol(element)
                        dismiss()
                }
                
            } else {
                HStack {
                   
                    DButtonComp(
                        text: "Delete",
                        color: .red,
                        image: .none,
                        maxWidth: 80,
                        isEnabled: true ) {
                            if let index = index {
                                vm.eliminateProtocol(at: index )
                                dismiss()
                            }
                    }
                
                    DButtonComp(
                        text: "Update Protocol",
                        color: .green,
                        image: "plus",
                        isEnabled: validation ) {
                            let updated = element
                            if let index = index {
                                vm.updateProtocol(updated, at: index)
                                dismiss()
                            }
                    }
                }
            }
        }.padding(.horizontal)
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "shield.lefthalf.filled")
                Text(mode == .add ? "Add Protocol" :"Update Protocol")
            }
            .font(.title.bold())
            .foregroundColor(.yellow)
            
            
            if mode == .add {
                Text("Add title, description and tasks to the protocol")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    private var nameandDescription: some View {
        VStack(spacing: 4) {
            TextFieldComp(text: $element.name, prompt: "Protocol Name", image: "pencil", color: .yellow)
            
            TextFieldComp(
                text: Binding(
                    get: { element.description ?? "" },
                    set: { element.description = $0.isEmpty ? nil : $0 }
                ),
                prompt: "Protocol Description",
                image: "list.dash"
            )
        }
    }
    private var importanceView: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text("Select the protocol's importance")
                .foregroundStyle(.secondary)
            
            Picker("Importance", selection: $element.importance) {
                ForEach(ProtocolImportance.allCases, id: \.self) { item in
                    Text(item.rawValue).tag(item)
                }
            }.pickerStyle(.segmented)
            
            HStack {
                ForEach(colors, id: \.self) { color in
                    Capsule()
                        .foregroundStyle(color)
                }
            }
        }
    }
    private var timeAction: some View {
        HStack {
            Text("Select the protocol's time action:")
                .foregroundStyle(.secondary)
                .font(.subheadline)
            
            Spacer()
            
            Picker("Time Action", selection: $element.time) {
                ForEach(ProtocolTime.allCases, id: \.self) { item in
                    Text(item.rawValue).tag(item)
                }
            }
            .pickerStyle(.menu)
            .tint(.red)
        }
        .padding(7)
        .background {
            Color.gray.opacity(0.2)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 10)
        }
    }
    private var subTasks: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            if element.tasks.isEmpty {
                HStack {
                    Text("Add task to this protocol")
                    Image(systemName: "plus")
                }.foregroundStyle(.secondary)
                
            } else {
                ForEach(element.tasks, id: \.id) { task in
                    taskRow(task)
                }
            }
            
            HStack {
                if element.tasks.isEmpty {
                    EmptyView()
                } else {
                    DButtonComp(text: "Pop last", color: .gray, image: "",style: .neutral ,  maxHeight: 10) {
                        guard element.tasks.count == 1 else { return }
                        _ = element.tasks.popLast()
                    }
                }
                
                DButtonComp(text: "Add Task", color: .yellow, image: "plus", maxHeight: 10) {
                    isPresented.toggle()
                }
               
            }
            .padding(.top)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .customBackground(color: .gray.opacity(0.2))
    }
    private func taskRow(_ task: ProtocolTask) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 8, height: 15)
                    .foregroundStyle(.yellow)
                
                Text(task.taskName)
                    .font(.title3.bold())
            }
            
            Text(task.description ?? "No Description")
                    .foregroundStyle(.secondary)
            
        }
    }
}

private struct Sheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var collection: [ProtocolTask]
    @State private var name: String = ""
    @State private var description: String = ""
    var body: some View {
        VStack {
            TextFieldComp(text: $name, prompt: "Task Name", image: "pencil", color: .yellow)
            TextFieldComp(text: $description, prompt: "Task Description (optional)", image: "list.dash")
            
            HStack {
                DButtonComp(text: "Cancel", color: .gray, image: "",style: .neutral ,  maxHeight: 6) {
                    dismiss()
                }
                
                DButtonComp(text: "Add Task", color: .yellow, image: "plus", maxHeight: 10, isEnabled: name.count > 0) {
                    
                    collection.append(
                        ProtocolTask(
                            taskName: name,
                            description: description
                                    )
                    )
                    dismiss()
                }
            }
        }.padding(.horizontal, 10)
    }
}

#Preview {
    ProtocolDetailView(user: .mock, index: 0)
}
