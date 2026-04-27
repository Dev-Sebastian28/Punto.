import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var task: VTask = .init(
        id: .init(), title: "", description: "",
        deadLine: .now, importance: .medium, status: .pending
    )
    @State private var location: String = ""
    @State private var description: String = ""
    @State private var useLocation: Bool = false

    let vm: TaskViewModel

    private var isValid: Bool { !task.title.isEmpty }

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
                    locationSection
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

    // MARK: - Header

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.blue)
                        .frame(width: 28, height: 28)
                        .background(Color.blue.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text("New task")
                        .font(.title3.weight(.semibold))
                }

                Text("Fill in the details below to get started")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .frame(width: 30, height: 30)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
        }
    }

    // MARK: - Fields

    private var fieldsSection: some View {
        VStack(spacing: 10) {
            labeledField("Task name") {
                TextFieldComp(text: $task.title, prompt: "Task name...", leadingIcon: "pencil", color: .blue)
            }
            
            labeledField("Description") {
                TextFieldComp(text: $description, prompt: "Add a short description...", leadingIcon: "list.dash")
            }
        }
    }

    // MARK: - Importance

    private var importanceSection: some View {
        labeledField("Importance") {
            HStack(spacing: 8) {
                ForEach(TaskImportance.allCases, id: \.self) { level in
                    importanceButton(for: level)
                }
            }
        }
    }

    private func importanceButton(for level: TaskImportance) -> some View {
        let isSelected = task.importance == level
        let color = level.color

        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                task.importance = level
            }
        } label: {
            VStack(spacing: 6) {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                Text(level.rawValue)
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

    // MARK: - Deadline

    private var deadlineSection: some View {
        labeledField("Deadline") {
            DatePicker("", selection: $task.deadLine, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
                .labelsHidden()
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    // MARK: - Location

    private var locationSection: some View {
        labeledField("Location") {
            VStack(spacing: 10) {
                Toggle("Use location", isOn: $useLocation.animation())
                    .tint(.blue)

                if useLocation {
                    TextFieldComp(text: $location, prompt: "Search location...", leadingIcon: "location")
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    // MARK: - Buttons

    private var actionButtons: some View {
        HStack(spacing: 12) {
            DButtonComp(text: "cancel", color: .gray, image: .none, style: .neutral) {
                dismiss()

            }
            
            DButtonComp(text: "Add Task", color: .blue, image: "plus", style: .dominant, isEnabled: isValid) {
                vm.addTask(task)
                dismiss()
            }
            .animation(.easeInOut(duration: 0.2), value: isValid)
        }
    }

    // MARK: - Helper

    @ViewBuilder
    private func labeledField<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
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
    AddTaskView(vm: .init(user: .mock, selectedVehicle: 0))
}
