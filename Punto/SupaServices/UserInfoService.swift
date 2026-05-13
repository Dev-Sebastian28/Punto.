//
//  UserInfoService.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/05/26.
//

//
//  TaskRepository.swift
//  Punto
//
//  Created by Sebastian Garcia on 2/05/26.

import Foundation
import Auth
import Supabase


struct UserInfoService {
    var userId: UUID

    // MARK: Dependencies:
    private let postRequest: SupabaseINSERTRequestProtocol = INSERTRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "user_information"
    )
    private let getRequest: SupabaseGETRequestProtocol = GETRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "user_information"
    )
        
    
    // MARK: - init
    init(userId: UUID) {
        self.userId = userId
    }
    
    func post(userProfile: UserProfile) async {
        do {
            try await postRequest.insertItem(model: userProfile)
        } catch {
            print("Debug UserInfoService: Error Posting userProfile" + error.localizedDescription)
        }
    }
    
    func update(userProfile: UserProfile) async {
        
    }
    
    func get() async throws -> UserProfile? {
        do {
            let userProfile = try await getRequest.fetchItem(model: UserProfile.self, itemId: userId, columnName: "")
            return userProfile
        } catch {
            print("Debug UserInfoService: Error fetching userProfile" + error.localizedDescription)
        }
        return nil
    }
    
    func uploadAvatarImage(data: Data) async -> String? {
        do {
            // MARK: Important
            // This is how the avatar image NAME in the bucket. eg. DAE2139D-12D1D-12ED1.jpg
            let setUpFileName = "\(userId).jpg"
            
            let storage = SupabaseManagerSingleton.shared.client.storage.from("avatars")
            
            try await storage.upload(
                setUpFileName,
                data: data,
                options: FileOptions(contentType: "image/jpeg")
            )
            
            // MARK: Important
            // Url of the avatar image to show in the View
            let url = try storage.getPublicURL(path: setUpFileName)
            return url.absoluteString
            
        } catch {
            print("Debug UserInfoService:  ❌ Avatar Image upload error: \(error)")
            return nil
        }
    }
}




