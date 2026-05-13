//
//  CreationAccountView.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/05/26.
//

import SwiftUI
import PhotosUI

struct CreationAccountView: View {
    
    // MARK: Avatar (Profile Picture)
    @State private var pickerItem: PhotosPickerItem?
    @State private var uiImage: UIImage?
    @State private var selectedImageData: Data?
    
    // MARK: User information
    @State private var fullName: String = ""
    @State private var phone: Int = 0
    @State private var vehiclesNumber: Int = 1
    
    // MARK: - View Model
    @State private var vm: CreationAccountViewModel
    
    @Environment(AppCoordinator.self) var coordinator
    
    private var isValid: Bool {
        !fullName.isEmpty && phone > 0
    }
    
    // MARK: - Init
    init(appState: AppState) {
        _vm = State(initialValue: CreationAccountViewModel(appState: appState))
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack(spacing: 24) {
                        header
                        imagePicker
                        userInfo
                        vehiclesPicker
                        
                    }.padding(.horizontal)
                }
                
                
                DButtonComp(
                    text: "Create Account",
                    color: .green,
                    image: "checkmark",
                    isEnabled: isValid
                ) {
                    Task {
                        await vm.createAccount(
                            fullName: fullName,
                            phone: String(phone),
                            avatarData: selectedImageData
                        )
                        
                        coordinator.onBoardingCoordinator.uniqueNavigation(to: .form1)
                    }
                }.padding()
            }
        }.onChange(of: pickerItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data),
                   let compressedData = image.jpegData(compressionQuality: 0.5) {
                    selectedImageData = compressedData
                    uiImage = image
                }
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Text("Create Account")
                    .font(.title.bold())
                
                Spacer()
                
                Button {
                    coordinator.onBoardingCoordinator.uniqueNavigation(to: .form1)
                } label: {
                    Text("Later")
                        .genericCapsuleBackground(color: .blue.opacity(0.3))
                }
            }
        }
    }
    
    private var imagePicker: some View {
        PhotosPicker(selection: $pickerItem, matching: .images) {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(.circle)
            } else {
                VStack(spacing: 0) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 100))
                        .foregroundStyle(.blue)
                    Text("Select a profile picture")
                }
            }
        }
    }
    
    private var userInfo: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Enter your personal info")
                Text("optional (Recommended)")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            VStack(spacing: 16) {
                
                TextFieldComp(
                    text: $fullName,
                    prompt: "Full name",
                    leadingIcon: "person"
                )
                
                TextFieldComp(
                    intValue: $phone,
                    prompt: "Phone number ",
                    leadingIcon: "phone"
                )
            }.genericRoundedBackground(color: .platformSystemBackground)
        }
    }
    
    private var vehiclesPicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Vehicles")
                .font(.headline)
            
            HStack {
                Text("How many do you have?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Picker("", selection: $vehiclesNumber) {
                    ForEach(1...20, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }.pickerStyle(.menu)
            }
        }.genericRoundedBackground(color: .platformSystemBackground)
    }
    
}


#Preview {
    CreationAccountView(appState: AppState())
        .environment(AppCoordinator(appState: AppState()))
}
