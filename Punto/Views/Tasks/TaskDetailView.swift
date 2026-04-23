import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var editedTask: VTask
    let index: Int
    let oldTask: VTask
    let vm: TaskViewModel

    private var hasChanges: Bool { editedTask != oldTask }

    init(task: VTask, vm: TaskViewModel, index: Int) {
        _editedTask = State(initialValue: task)
        self.vm = vm
        self.oldTask = task
        self.index = index
    }

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
                    fieldsSection
                    importanceSection
                    deadlineSection
                    statusSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }

            actionButtons
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
                .padding(.top, 12)
                .background(.ultraThinMaterial)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}


private extension TaskDetailView {

    var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.green)
                        .frame(width: 28, height: 28)
                        .background(Color.green.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text("Edit task")
                        .font(.title3.weight(.semibold))
                }
                Text("Make changes and save when ready")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // Status badge
            Text(editedTask.status.rawValue.capitalized)
                .font(.caption.weight(.semibold))
                .foregroundStyle(editedTask.status.color)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(editedTask.status.color.opacity(0.12))
                .clipShape(Capsule())
                .overlay(Capsule().stroke(editedTask.status.color.opacity(0.3), lineWidth: 0.5))
        }
    }

    var fieldsSection: some View {
        VStack(spacing: 10) {
            labeledField("Task name") {
                TextFieldComp(
                    text: $editedTask.title,
                    prompt: "Task name...",
                    image: "pencil",
                    color: .blue,
                    isAdaptative: true
                )
            }

            labeledField("Description") {
                VStack(alignment: .leading, spacing: 0) {
                    TextEditor(
                        text: Binding(
                            get: { editedTask.description ?? "" },
                            set: { editedTask.description = $0.isEmpty ? nil : $0 }
                        )
                    )
                    .frame(minHeight: 80)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                }
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }

    var importanceSection: some View {
        labeledField("Importance") {
            HStack(spacing: 8) {
                ForEach(TaskImportance.allCases, id: \.self) { level in
                    importanceButton(for: level)
                }
            }
        }
    }

    func importanceButton(for level: TaskImportance) -> some View {
        let isSelected = editedTask.importance == level
        let color = level.color

        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                editedTask.importance = level
            }
        } label: {
            VStack(spacing: 6) {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                Text(level.rawValue.capitalized)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isSelected ? color.opacity(0.12) : Color(.systemGray6))
            .foregroundStyle(isSelected ? color : .secondary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? color : Color.clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }

    var deadlineSection: some View {
        labeledField("Deadline") {
            DatePicker("", selection: $editedTask.deadLine, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
                .labelsHidden()
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    var statusSection: some View {
        labeledField("Status") {
            HStack(spacing: 8) {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    statusButton(for: status)
                }
            }
        }
    }

    func statusButton(for status: TaskStatus) -> some View {
        let isSelected = editedTask.status == status
        let color = status.color

        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                editedTask.status = status
            }
        } label: {
            Text(status.rawValue.capitalized)
                .font(.caption)
                .fontWeight(isSelected ? .semibold : .regular)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(isSelected ? color.opacity(0.12) : Color(.systemGray6))
                .foregroundStyle(isSelected ? color : .secondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? color : Color.clear, lineWidth: 1.5)
                )
        }
        .buttonStyle(.plain)
    }

    var actionButtons: some View {
        HStack(spacing: 12) {
            Button("Cancel") { dismiss() }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(.systemGray6))
                .foregroundStyle(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            Button {
                vm.updateTask(editedTask, at: index)
                dismiss()
            } label: {
                Label("Save changes", systemImage: "checkmark")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .background(hasChanges ? Color.green : Color.green.opacity(0.4))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .disabled(!hasChanges)
            .animation(.easeInOut(duration: 0.2), value: hasChanges)
        }
    }


    @ViewBuilder
    func labeledField<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.secondary)
                .tracking(0.6)
            content()
        }
    }
}



#Preview {
    TaskDetailView(
        task: VTask(
            id: .init(),
            title: "Wash the car",
            description: "Interior and exterior cleaning",
            deadLine: .now,
            importance: .medium,
            status: .pending,
        ),
        vm: .init(user: .mock, selectedVehicle: 0), index: 0
    )
}
