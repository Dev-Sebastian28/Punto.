//
//  CreationAccountViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 5/05/26.
//
import Foundation
import Supabase

@Observable
final class CreationAccountViewModel {
    private var appState: AppState
    

    // MARK: - Dependencies:
    let service: UserInfoService
    
    func createAccount(fullName: String, phone: String, avatarData: Data?) async {
        
        let email = SupabaseManagerSingleton.shared.client.auth.currentUser?.email ?? ""
        var imageUrl: String? = nil
        
        if let avatarData {
            imageUrl = await uploadImage(data: avatarData)
        }

        var model: UserProfile = UserProfile(
            id: appState.user.id,
            fullName: fullName,
            phone: phone,
            email: email,
            avatar: imageUrl
        )
        
        await service.post(userProfile: model)
        
        self.appState.user.userInformation = model
    }
    
    func updateAccount(fullName: String, phone: String, avatarData: Data?) async {
        
    }
    
    func uploadImage(data: Data) async -> String? {
        await service.uploadAvatarImage(data: data)
    }
     
    init(appState: AppState) {
        self.appState = appState
        self.service = UserInfoService(userId: appState.user.id)
    }
}
