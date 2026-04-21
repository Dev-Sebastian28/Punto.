import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var editedTask: VTask
    let oldTask: VTask
    let vm: TaskListViewModel
    
    private let importanceColors: [Color] = [.green, .yellow, .red]

    private var isValid: Bool {
        editedTask != oldTask
    }

    init(task: VTask, vm: TaskListViewModel) {
        _editedTask = State(initialValue: task)
        self.vm = vm
        self.oldTask = task
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Spacer()

            header
            nameAndDescription
            importanceView
            taskDeadline
            actions
        }.padding(.horizontal)
    }
}

private extension TaskDetailView {
    var header: some View {
        HStack(spacing: 8) {
            Image(systemName: "square.and.pencil")
            Text("Update Task")
        }
        .font(.title.bold())
        .foregroundStyle(.blue)
    }

    var nameAndDescription: some View {
        VStack(spacing: 4) {
            TextFieldComp(
                text: $editedTask.title,
                prompt: "Task Name", image: "pencil",
                color: .blue,
                isAdaptative: true
            )
            
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
    var taskDeadline: some View {
        DatePicker("Select date", selection: $editedTask.deadLine, displayedComponents: [.date, .hourAndMinute])
            .datePickerStyle(.compact)
            .customBackground(color: .gray.opacity(0.2))
    }
    var actions: some View {
        HStack {
            DButtonComp(
                text: "Cancel",
                color: .gray,
                image: .none,
                style: .neutral,
                maxHeight: 10
            ) {
                dismiss()
            }

            DButtonComp(
                text: "Save Changes",
                color: .blue,
                image: "square.and.arrow.down",
                maxHeight: 10,
                isEnabled: isValid
            ) {
                vm.updateTask(editedTask)
                dismiss()
            }
        }
    }
}

#Preview {
    TaskDetailView(
        task: VTask(
            title: "Wash the car",
            description: "Interior and exterior cleaning",
            date: .now,
            importance: .medium,
            status: .pending
        ),
        vm: .init(user: .mock)
    )
}
