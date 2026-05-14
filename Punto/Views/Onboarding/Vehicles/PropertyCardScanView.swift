import SwiftUI
import PhotosUI

struct PropertyCardScanView: View {
    // MARK: Properties:
    @State private var isPresented: Bool = false
    
    // MARK: Photo Properties:
    @State private var selectedItem: PhotosPickerItem?
    @State private var uiImage: UIImage?
    
    @State private var extractedInfo: VehicleInformation? = .sample
    
    @Environment(AppCoordinator.self) var coordinator


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                imagePicker
                if let info = extractedInfo {
                    extractedDataCard(info: info)
                    actionButtons(info: info)
                }
            }.padding()
        }
        .onChange(of: selectedItem) { _, newItem in
            Task {
                guard let data = try? await newItem?.loadTransferable(type: Data.self),
                      let image = UIImage(data: data) else { return }
                uiImage = image
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Property card")
                
                Spacer()
                
                Group {
                    Image(systemName: "car")
                    Image(systemName: "person.text.rectangle.fill")
                }.font(.title3)
            }.font(.largeTitle.weight(.bold))
            
            Text("Take a photo and we'll extract the details")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var imagePicker: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(alignment: .topTrailing) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .padding(10)
                    }
            } else {
                uploadPlaceholder
            }
        }
        .buttonStyle(.plain)
    }

    private var uploadPlaceholder: some View {
        VStack(spacing: 12) {
            Image(systemName: "camera.fill")
                .font(.title)
                .foregroundStyle(.secondary)
            Text("Take a photo or upload")
                .font(.subheadline.weight(.medium))
            Text("Make sure all text is visible and well lit")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .background(Color.platformGroupedBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [6]))
                .foregroundStyle(.tertiary)
        }
    }

    private func extractedDataCard(info: VehicleInformation) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Vehicle details")
                    .font(.subheadline.weight(.semibold))
        
                Spacer()
                
                Label("AI extracted", systemImage: "sparkles")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.green)
                    .genericCapsuleBackground(color: .green.opacity(0.1))
            }.padding(.bottom)

            infoRow(label: "Plate:",value: info.plate)
                .onTapGesture {
                    isPresented.toggle()
                }
            infoRow(label: "Brand:",value: info.brand)
            infoRow(label: "Model:",value: info.model)
            infoRow(label: "Year:",value: "\(info.year)")
            infoRow(label: "Engine:",value: info.engine)
            infoRow(label: "Fuel:",value: info.fuel.rawValue.capitalized)
            infoRow(label: "Transmission:", value: info.transmission.rawValue.capitalized)
        }
        .genericRoundedBackground(color: .gray.opacity(0.1))
        .sheet(isPresented: $isPresented) {
            EditValue(valueName: "", value: .constant(""))
                .presentationDetents([.height(160)])
        }
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline.weight(.medium))
        }
        .padding(.vertical, 8)
        .overlay(alignment: .bottom) { Divider() }
    }
    
    private func actionButtons(info: VehicleInformation) -> some View {
        HStack(spacing: 12) {
            DButtonComp(
                text: "Retry",
                color: .gray,
                image: "arrow.triangle.2.circlepath",
                style: .neutral
            ) {
                extractedInfo = nil
                uiImage = nil
                selectedItem = nil
            }
            DButtonComp(
                text: "Create",
                color: .green,
                image: "checkmark"
            ) {
            }
        }
    }
}

private struct EditValue: View {
    let valueName: String
    @Binding var value: String
    var body: some View {
        VStack {
            Spacer()
            Label(valueName, systemImage: "pencil")
            TextFieldComp(text: $value, prompt: "Edit \(valueName)", leadingIcon: "pencil")
                .padding()
        }
    }
}

#Preview {
    PropertyCardScanView()
        .environment(AppCoordinator(appState: AppState()))
}
