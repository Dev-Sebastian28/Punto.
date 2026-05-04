//
//  SupabaseManager.swift
//  Punto
//
//  Created by Sebastian Garcia on 29/04/26.
//
import Supabase
import Auth
import Foundation


final class SupabaseManagerSingleton {
    static let shared = SupabaseManagerSingleton()
    
    let client = SupabaseClient(
        supabaseURL: URL(string: AppConstants.baseURL)!,
        supabaseKey: AppConstants.projectAPIKey,
        options: SupabaseClientOptions(
            auth: .init(storage: KeychainStorage()) 
        )
    )
    private init() {}
}
