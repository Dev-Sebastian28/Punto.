//
//  ProtocolForm.swift
//  Punto
//
//  Created by Sebastian Garcia on 7/04/26.
//

import SwiftUI

struct AddProtocolView: View {
    @State private var name: String = ""
    @State private var protocolDescription: String = ""
    @State private var importance: ProtocolImportance = .medium
    @State private var time: ProtocolTime = .daily
    @State private var tasks: [ProtocolTask] = [.init(taskName: "Check for bugs", isActive: false), .init(taskName: "Fix bugs", isActive: false)]
    @State private var isPresented: Bool = false
    let colors: [Color] = [.green, .yellow, .red]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                
                header
                
                VStack(spacing: 4) {
                    TextFieldComp(text: $name, prompt: "Protocol Name", image: "pencil", color: .yellow)
                    
                    TextFieldComp(text: $protocolDescription, prompt: "Protocol Description", image: "list.dash")
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Select the protocol's importance")
                        .foregroundStyle(.secondary)
                    Picker("Importance", selection: $importance) {
                        ForEach(ProtocolImportance.allCases, id: \.self) { item in
                            Text(item.rawValue).tag(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Capsule()
                                .foregroundStyle(color)
                        }
                    }
                }
                
                HStack {
                    Text("Select the protocol's time action:")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Picker("Time Action", selection: $time) {
                        ForEach(ProtocolTime.allCases, id: \.self) { item in
                            Text(item.rawValue).tag(item)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.blue)
                }
                .padding(7)
                .background {
                    Color.gray.opacity(0.2)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 10)
                }
                
                
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(tasks, id: \.id) { task in
                        taskRow(task)
                    }
                    HStack {
                        DButtonComp(text: "Pop last", color: .gray, image: "",style: .neutral ,  maxHeight: 10) {
                            
                        }
                        
                        DButtonComp(text: "Add Task", color: .yellow, image: "plus", maxHeight: 10) {
                            isPresented.toggle()
                        }
                       
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background {
                    Color.gray.opacity(0.1)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 10)
                }
                
            }.padding(.horizontal)
        }
        .sheet(isPresented: $isPresented) {
            Sheet(collection: $tasks)
                .presentationDetents([.height(200)])

        }
        
        
        VStack {
            DButtonComp(text: "Create Protocol", color: .green, image: "plus", isEnabled: !name.isEmpty && !tasks.isEmpty ) {
                
            }.padding(.horizontal)
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "shield.lefthalf.filled")
                Text("Add New Protocol")
            }
            .font(.title.bold())
            .foregroundColor(.yellow)
            
            
            Text("Add title, description and tasks to the protocol")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
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
    @Binding var collection: [ProtocolTask]
    @State private var name: String = ""
    @State private var description: String = ""
    var body: some View {
        VStack {
            TextFieldComp(text: $name, prompt: "Task Name", image: "pencil", color: .yellow)
            
            TextFieldComp(text: $description, prompt: "Task Description (optional)", image: "list.dash")
            
            HStack {
                DButtonComp(text: "Cancel", color: .gray, image: "",style: .neutral ,  maxHeight: 10) {
                    
                }
                
                DButtonComp(text: "Add Task", color: .blue, image: "plus", maxHeight: 10, isEnabled: name.count > 0) {
                    collection.append(ProtocolTask(taskName: name, description: description))
                    
                }
            }
        }.padding(.horizontal, 10)
    }
}

#Preview {
    AddProtocolView()
}
