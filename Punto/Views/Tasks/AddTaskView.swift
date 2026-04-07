import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var importance: TaskImportance = .medium
    @State private var date: Date = .now
    @State private var location: String = ""
    
    @Binding var tasks: [Task]
    
    private var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        ZStack {
            Color.platformGroupedBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 10) {
                    detailsSection
                    importanceSection
                    dateSection
                    locationSection
                    saveButton
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
        }
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - Sections
private extension AddTaskView {
    var detailsSection: some View {
        SectionCard(title: "Details") {
            InputField(icon: "textformat", title: "Title", placeholder: "Task name", text: $title)

            InputField(icon: "text.alignleft", title: "Description", placeholder: "Optional description", text: $description, isMultiline: true)
        }
    }

    var importanceSection: some View {
        SectionCard(title: "Importance") {
            Picker("", selection: $importance) {
                Label("Low", systemImage: "arrow.down").tag(TaskImportance.low)
                Label("Medium", systemImage: "arrow.left.and.right").tag(TaskImportance.medium)
                Label("High", systemImage: "arrow.up").tag(TaskImportance.high)
            }
            .pickerStyle(.segmented)
        }
    }

    var dateSection: some View {
        SectionCard(title: "Date") {
            DatePicker("Select date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
        }
    }

    var locationSection: some View {
        SectionCard(title: "Location") {
            InputField(icon: "mappin", title: "Location", placeholder: "Add a location", text: $location)
        }
    }
}

// MARK: - Save Button
private extension AddTaskView {
    var saveButton: some View {
        Button(action: saveTask) {
            HStack {
                Spacer()
                Label("Save Task", systemImage: "checkmark.circle.fill")
                    .font(.headline)
                Spacer()
            }
            .padding()
            .background(isValid ? Color.accentColor : Color.gray.opacity(0.3))
            .foregroundColor(.white)
            .cornerRadius(14)
        }
        .disabled(!isValid)
        .padding(.top, 10)
    }
}

// MARK: - Actions
private extension AddTaskView {
    func saveTask() {
        tasks.addTask(task: .init(title: title, description: description, date: date, importance: importance, status: .pending))
        print("Task saved:", title, description, importance, date, location)
        dismiss()
    }
}

// MARK: - Reusable Components

struct SectionCard<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)

            VStack(spacing: 12) {
                content
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.platformSystemBackground)
                .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
        )
    }
}

struct InputField: View {
    let icon: String
    let title: String
    let placeholder: String
    @Binding var text: String
    var isMultiline: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack(alignment: .top, spacing: 10) {
                Image(systemName: icon)
                    .foregroundStyle(.secondary)

                if isMultiline {
                    TextField(placeholder, text: $text, axis: .vertical)
                        .lineLimit(3...6)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.platformSecondaryBackground)
            )
        }
    }
}

#Preview {
    NavigationStack {
        AddTaskView(tasks: .constant([]))
    }
}
