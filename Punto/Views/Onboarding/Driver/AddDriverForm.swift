//
//  AddDriverForm.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct AddDriverForm: View {
    let selecteVehicleindex: Int
    
    @Environment(\.dismiss) private var dismiss
    @State private var driver: DriverInvitation
    @State private var phone: String = ""
    var vm: AddDriverViewModel

    
    private var isvalid: Bool {
        !driver.name.isEmpty && !driver.email.isEmpty && driver.phone != 0
    }
    init(vm: AddDriverViewModel, index: Int) {
        self.selecteVehicleindex = index
        self.vm = vm
        self.driver = .init(name: "", email: "", phone: 0, status: .pending)
    }
    
    var body: some View {
        VStack(spacing: 6) {
            TextFieldComp(
                text: $driver.name,
                prompt: "Driver Name",
                leadingIcon: "person.fill"
            ).padding(.bottom, 8)
            
            TextFieldComp(
                text: $phone,
                prompt: "Driver Phone Number",
                leadingIcon: "number"
            )
            TextFieldComp(
                text: $driver.email,
                prompt: "Driver Mail",
                leadingIcon: "at"
            )
            
            HStack {
                DButtonComp(
                    text: "Cancel",
                    color: .gray,
                    image: "x.circle.fill",
                    style: .neutral,
                    maxWidth: 120) {
                        dismiss()
                    }
                DButtonComp(
                    text: "Send",
                    color: .blue,
                    image: "paperplane.fill",
                    maxWidth: 200,
                    isEnabled: isvalid ) {
                        self.driver.phone = Int(phone) ?? 0
                        vm.sendInvitation(
                            driver,
                            forVehicle: selecteVehicleindex
                        )
                        dismiss()
                    }
            }.padding(.top, 30)
        }.padding(.horizontal)
    }
}

#Preview {
    AddDriverForm(vm: .init(user: .mock), index: 0)
}
