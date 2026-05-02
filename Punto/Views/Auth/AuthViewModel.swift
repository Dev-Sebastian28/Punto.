//
//  AuthViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//

import Foundation

// MARK: - Auth Status
enum AuthStatus {
    case notDetermined
    case authenticated
    case notAuthenticated
}

enum AuthMode {
    case signIn
    case signUp
}

// MARK: - Operation State
enum OperationState {
    case idle
    case loading
    case failure(AuthViewModelError)

    var error: AuthViewModelError? {
        if case .failure(let e) = self { return e }
        return nil
    }

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
}

// MARK: - AuthViewModelError
enum AuthViewModelError: Error {
    case validation(String)
    case service(String)
    case unknown

    var displayMessage: String {
        switch self {
        case .validation(let msg): return msg
        case .service(let msg):    return msg
        case .unknown:             return "Unknow erorr"
        }
    }
}

// MARK: - ViewModel
@Observable @MainActor
final class AuthViewModel {

    // Used weak to not create a strong reference to "AuthCoordinator"
    private weak let coordinator: AuthCoordinator?
    
    // MARK: State
    private(set) var mode: AuthMode
    private(set) var authStatus: AuthStatus = .notDetermined
    private(set) var operationState: OperationState = .idle

    // MARK: Dependencies 
    private let service: any AuthServiceProtocol
    private let validator: AuthValidator = AuthValidator()

    // MARK: Init
    init(mode: AuthMode = .signUp, service: any AuthServiceProtocol, coordinator: AuthCoordinator) {
        self.mode = mode
        self.service = service
        self.coordinator = coordinator
    }
    
    var suggestion : String {
        return operationState.error?.displayMessage ?? ""
    }

    func changeAuthMode(_ mode: AuthMode) {
        self.mode = mode
        self.operationState = .idle
    }

    func login(email: String, password: String) async {
        guard localValidate(email: email, password: password) else { return }
        await perform { try await self.service.login(email: email, password: password) }
    }

    func signUp(email: String, password: String) async {
        guard localValidate(email: email, password: password) else { return }
        await perform { try await self.service.signup(email: email, password: password) }
    }


    // MARK: Private
    /// Valida localmente y setea el estado si falla. Devuelve `true` si pasó.
    @discardableResult
    private func localValidate(email: String, password: String) -> Bool {
        switch mode {
        case .signIn:
            do {
                let isEmailValid = try validator.emailValidation(email: email)
                return isEmailValid
            } catch let error as ValidatorError {
                operationState = .failure(.validation(error.suggestion))
                return false
            } catch {
                operationState = .failure(.validation(error.localizedDescription))
                return false
            }
        case .signUp:
            do {
                let isEmailValid = try validator.emailValidation(email: email)
                let isPasswordSecure = try validator.passwordValidation(password: password)
                return isEmailValid && isPasswordSecure
                
            } catch let error as ValidatorError {
                operationState = .failure(.validation(error.suggestion))
                return false
            } catch {
                operationState = .failure(.validation(error.localizedDescription))
                return false
            }
        }
    }
    
    @MainActor
    /// It manages loading status and errors, The local inputs validation already happened before, it also talks to the cordinator via delegate.
    private func perform(operation: () async throws -> AuthStatus) async {
        operationState = .loading
        defer {
            if operationState.isLoading { operationState = .idle }
        }
        
        do {
            authStatus = try await operation()
            operationState = .idle
            
            // Coordiantor Callback or delegate depending on the mode
            switch mode {
            case .signIn:
                coordinator?.didFinishLogin()
            case .signUp:
                coordinator?.didFinishSignUp()
            }
            
        } catch {
            operationState = .failure(.service(error.localizedDescription))
        }
    }

    private func mapError(_ error: Error) -> AuthViewModelError {
        .service(error.localizedDescription)
    }
}
