import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var editedTask: Task
    let vm: TaskListViewModel

    private let importanceColors: [Color] = [.green, .yellow, .red]

    private var isValid: Bool {
        !editedTask.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    init(task: Task, vm: TaskListViewModel) {
        _editedTask = State(initialValue: task)
        self.vm = vm
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Spacer()

            header
            nameAndDescription
            importanceView
            statusView
            taskDeadline
            actions
        }
        .padding(.horizontal)
    }
}

private extension TaskDetailView {
    var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: "square.and.pencil")
                Text("Update Task")
            }
            .font(.title.bold())
            .foregroundStyle(.blue)

            Text("Edita el nombre, descripción, prioridad, estado y fecha de la tarea.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    var nameAndDescription: some View {
        VStack(spacing: 4) {
            TextFieldComp(text: $editedTask.title, prompt: "Task Name", image: "pencil", color: .blue)
            TextFieldComp(
                text: Binding(
                    get: { editedTask.description ?? "" },
                    set: { editedTask.description = $0.isEmpty ? nil : $0 }
                ),
                prompt: "Task Description",
                image: "list.dash"
            )
        }
    }

    var importanceView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Task importance")
                .foregroundStyle(.secondary)

            Picker("Importance", selection: $editedTask.importance) {
                ForEach(TaskImportance.allCases, id: \.self) { importance in
                    Text(importance.rawValue.capitalized).tag(importance)
                }
            }
            .pickerStyle(.segmented)

            HStack {
                ForEach(importanceColors, id: \.self) { color in
                    Capsule()
                        .foregroundStyle(color)
                }
            }
            .frame(maxHeight: 10)
        }
    }

    var statusView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Task status")
                .foregroundStyle(.secondary)

            Picker("Status", selection: $editedTask.status) {
                Text("Pending").tag(TaskStatus.pending)
                Text("In Progress").tag(TaskStatus.inProgress)
                Text("Done").tag(TaskStatus.done)
            }
            .pickerStyle(.segmented)
        }
        .customBackground(color: .gray.opacity(0.2))
    }

    var taskDeadline: some View {
        DatePicker("Select date", selection: $editedTask.date, displayedComponents: [.date, .hourAndMinute])
            .datePickerStyle(.compact)
            .customBackground(color: .gray.opacity(0.2))
    }

    var actions: some View {
        HStack {
            DButtonComp(text: "Cancel", color: .gray, image: .none, style: .neutral, maxHeight: 10) {
                dismiss()
            }

            DButtonComp(text: "Save Changes", color: .blue, image: "square.and.arrow.down", maxHeight: 10, isEnabled: isValid) {
                vm.updateTask(editedTask)
                dismiss()
            }
        }
    }
}

#Preview {
    TaskDetailView(
        task: Task(
            title: "Wash the car",
            description: "Interior and exterior cleaning",
            date: .now,
            importance: .medium,
            status: .pending
        ),
        vm: .init(user: .mock)
    )
}
