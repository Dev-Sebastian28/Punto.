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
    @State private var isPresented = false
    @State private var element: VehicleProtocol
    let oldElement: VehicleProtocol
    let mode: Mode
    let index: Int?
    var vm: ProtocolViewModel
    
    private var isValid: Bool {
        switch mode {
        case .add:  return !element.name.isEmpty && !element.tasks.isEmpty
        case .edit: return oldElement != element
        }
    }
    
    // MARK: - Inits (sin cambios)
    
    init(user: User, index: Int) {
        let empty = VehicleProtocol(id: .init(), name: "", description: nil,
                                    tasks: [], importance: .medium, time: .daily)
        _element = State(initialValue: empty)
        self.oldElement = empty
        self.vm = .init(user: user, selectedVehicleIndex: index)
        self.index = index
        self.mode = .add
    }
    
    init(user: User, element: VehicleProtocol, index: Int) {
        _element = State(initialValue: element)
        self.oldElement = element
        self.vm = .init(user: user, selectedVehicleIndex: index)
        self.index = index
        self.mode = .edit
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color(.systemGray4))
                .frame(width: 36, height: 4)
                .padding(.top, 12)
                .padding(.bottom, 20)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    infoSection
                    importanceSection
                    frequencySection
                    tasksSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            
            actionButtons
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .sheet(isPresented: $isPresented) {
            AddTaskSheet(collection: $element.tasks)
                .presentationDetents([.height(220)])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Subviews

private extension ProtocolDetailView {
    
    var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "shield.lefthalf.filled")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.orange)
                        .frame(width: 28, height: 28)
                        .background(Color.orange.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text(mode == .add ? "Add protocol" : "Edit protocol")
                        .font(.title3.weight(.semibold))
                }
                if mode == .add {
                    Text("Name, description and tasks")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .frame(width: 30, height: 30)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
        }
    }
    
    var infoSection: some View {
        labeledField("Protocol info") {
            VStack(spacing: 8) {
                TextFieldComp(text: $element.name,
                              prompt: "Protocol name...",
                              leadingIcon: "pencil", color: .orange)
                TextFieldComp(
                    text: Binding(
                        get: { element.description ?? "" },
                        set: { element.description = $0.isEmpty ? nil : $0 }
                    ),
                    prompt: "Optional description...",
                    leadingIcon: "list.dash"
                )
            }
        }
    }
    
    var importanceSection: some View {
        labeledField("Importance") {
            HStack(spacing: 8) {
                ForEach(ProtocolImportance.allCases, id: \.self) { level in
                    importanceButton(for: level)
                }
            }
        }
    }
    
    func importanceButton(for level: ProtocolImportance) -> some View {
        let isSelected = element.importance == level
        let color = level.color   // ver extensión abajo
        
        return Button {
            withAnimation(.easeInOut(duration: 0.2)) { element.importance = level }
        } label: {
            VStack(spacing: 6) {
                Circle().fill(color).frame(width: 8, height: 8)
                Text(level.rawValue.capitalized)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isSelected ? color.opacity(0.12) : Color(.systemGray6))
            .foregroundStyle(isSelected ? color : .secondary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? color : Color.clear, lineWidth: 1.5))
        }
        .buttonStyle(.plain)
    }
    
    var frequencySection: some View {
        labeledField("Frequency") {
            HStack {
                Label("Time action", systemImage: "clock")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Picker("", selection: $element.time) {
                    ForEach(ProtocolTime.allCases, id: \.self) { t in
                        Text(t.rawValue).tag(t)
                    }
                }
                .pickerStyle(.menu)
                .tint(.orange)
            }
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    var tasksSection: some View {
        labeledField("Tasks") {
            VStack(spacing: 0) {
                if element.tasks.isEmpty {
                    // Empty state
                    VStack(spacing: 8) {
                        Image(systemName: "checklist")
                            .font(.system(size: 24))
                            .foregroundStyle(.orange.opacity(0.5))
                        Text("No tasks yet")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text("Tap Add task to get started")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    // Task list
                    VStack(spacing: 0) {
                        ForEach(Array(element.tasks.enumerated()), id: \.element.id) { i, task in
                            taskRow(task, isLast: i == element.tasks.count - 1)
                        }
                    }
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Add task button
                Button {
                    isPresented.toggle()
                } label: {
                    Label("Add task", systemImage: "plus")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.orange)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 11)
                        .background(Color.orange.opacity(0.10))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.orange.opacity(0.3), lineWidth: 0.5))
                }
                .padding(.top, 8)
            }
        }
    }
    
    func taskRow(_ task: ProtocolTask, isLast: Bool) -> some View {
        HStack(alignment: .top, spacing: 10) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.orange)
                .frame(width: 4, height: 38)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(task.taskName)
                    .font(.subheadline.weight(.medium))
                Text(task.description ?? "No description")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Swipe-to-delete would be ideal, but a small X works in sheets
            Button {
                withAnimation {
                    element.tasks.removeAll { $0.id == task.id }
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundStyle(.secondary)
                    .frame(width: 22, height: 22)
                    .background(Color(.systemBackground))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .overlay(alignment: .bottom) {
            if !isLast {
                Divider().padding(.leading, 28)
            }
        }
    }
    
    // MARK: - Action buttons
    
    @ViewBuilder
    var actionButtons: some View {
        if mode == .add {
            Button {
                vm.addProtocol(element)
                dismiss()
            } label: {
                Label("Create protocol", systemImage: "plus")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(isValid ? Color.orange : Color.orange.opacity(0.4))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .disabled(!isValid)
            .animation(.easeInOut(duration: 0.2), value: isValid)
            
        } else {
            HStack(spacing: 10) {
                // Delete
                Button {
                    if let index { vm.eliminateProtocol(at: index); dismiss() }
                } label: {
                    Label("Delete", systemImage: "trash")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.red)
                        .padding(.vertical, 15)
                        .frame(maxWidth: 110)
                        .background(Color.red.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.red.opacity(0.25), lineWidth: 0.5))
                }
                
                // Save
                Button {
                    if let index { vm.updateProtocol(element, at: index); dismiss() }
                } label: {
                    Label("Save changes", systemImage: "checkmark")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(isValid ? Color.orange : Color.orange.opacity(0.4))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(!isValid)
                .animation(.easeInOut(duration: 0.2), value: isValid)
            }
        }
    }
    
    // MARK: - Helper
    
    @ViewBuilder
    func labeledField<C: View>(_ title: String, @ViewBuilder content: () -> C) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Text(title.uppercased())
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .tracking(0.6)
                // Badge de conteo solo en tasks
                if title == "Tasks" && !element.tasks.isEmpty {
                    Text("\(element.tasks.count)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.orange)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 1)
                        .background(Color.orange.opacity(0.12))
                        .clipShape(Capsule())
                }
            }
            content()
        }
    }
}

// MARK: - Add Task Sheet

private struct AddTaskSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var collection: [ProtocolTask]
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text("New task")
                    .font(.headline)
                Spacer()
                Button { dismiss() } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 28, height: 28)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                }
            }
            .padding(.top, 4)
            
            TextFieldComp(text: $name, prompt: "Task name...", leadingIcon: "pencil", color: .orange)
            TextFieldComp(text: $description, prompt: "Description (optional)", leadingIcon: "list.dash")
            
            HStack(spacing: 10) {
                Button("Cancel") { dismiss() }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Color(.systemGray6))
                    .foregroundStyle(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button {
                    collection.append(ProtocolTask(
                        taskName: name,
                        description: description.isEmpty ? nil : description
                    ))
                    dismiss()
                } label: {
                    Label("Add", systemImage: "plus")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(name.isEmpty ? Color.orange.opacity(0.4) : Color.orange)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(name.isEmpty)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

// MARK: - Extensions

extension ProtocolImportance {
    var color: Color {
        switch self {
        case .low:    return .green
        case .medium: return .orange
        case .high:   return .red
        }
    }
}

#Preview {
    ProtocolDetailView(user: .mock, index: 0)
}
