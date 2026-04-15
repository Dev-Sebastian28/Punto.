import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var importance: TaskImportance = .medium
    @State private var date: Date = .now
    @State private var isOn: Bool = false
    @State private var location: String = ""
    let vm: TaskListViewModel
    
    
    let colors: [Color] = [.green, .yellow, .red]
    private var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Spacer()
            
            header
                .padding(.bottom)
            nameandDescription
            importanceView
            taskDeadline
            locationView
        }.padding(.horizontal)
        
        HStack {
            DButtonComp(text: "Cancell", color: .gray, image: .none, style: .neutral, maxHeight: 10) {
                dismiss()
            }
            
            DButtonComp(text: "Add Task", color: .blue, image: "plus", maxHeight: 10, isEnabled: isValid) {
                vm.addTask(
                    Task(title: title,
                         description: description,
                         date: date,
                         importance: importance
                        )
                )
                dismiss()
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "plus")
                Text("Add New task")
            }
            .font(.title.bold())
            .foregroundColor(.blue)
            
            
            Text("Add title, description and even location")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    private var nameandDescription: some View {
        VStack(spacing: 4) {
            TextFieldComp(text: $title, prompt: "Task Name", image: "pencil", color: .blue)
            
            TextFieldComp(text: $description, prompt: "Task Description", image: "list.dash")
        }
    }
    private var importanceView: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text("Select the protocol's importance")
                .foregroundStyle(.secondary)
            
            Picker("Importance", selection: $importance) {
                ForEach(TaskImportance.allCases, id: \.self) { item in
                    Text(item.rawValue).tag(item)
                }
            }.pickerStyle(.segmented)
            
            HStack {
                ForEach(colors, id: \.self) { color in
                    Capsule()
                        .foregroundStyle(color)
                }
            }.frame(maxHeight: 10)
        }
    }
    private var taskDeadline: some View {
        VStack {
            DatePicker("Select date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
        }.customBackground(color: .gray.opacity(0.2))
    }
    private var locationView: some View {
        VStack {
            Toggle("Use location (Google Maps)", isOn: $isOn)
                .tint(.blue)
            if isOn {
                TextFieldComp(text: $location, prompt: "Location", image: "location", color: .blue)
            }
        }.customBackground(color: .gray.opacity(0.2))
    }
    
}

#Preview {
    AddTaskView(vm: .init(user: .mock))
}
