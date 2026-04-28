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

    // MARK: State
    private(set) var mode: AuthMode
    private(set) var authStatus: AuthStatus = .notDetermined
    private(set) var operationState: OperationState = .idle

    // MARK: Dependencies 
    private let service: any AuthServiceProtocol
    private let validator: AuthValidator = .init()

    // MARK: Init
    init(mode: AuthMode, service: any AuthServiceProtocol) {
        self.mode = mode
        self.service = service
    }
    
    var suggestion : String {
        return operationState.error?.displayMessage ?? ""
    }

    // MARK: Public Interface
    func setMode(_ mode: AuthMode) {
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

    /// Maneja loading y errores de servicio. La validación ya ocurrió antes.
    private func perform(operation: () async throws -> AuthStatus) async {
        operationState = .loading
        defer {
            if operationState.isLoading { operationState = .idle }
        }
        
        do {
            authStatus = try await operation()
            operationState = .idle
        } catch {
            operationState = .failure(.service(error.localizedDescription))
        }
    }

    private func mapError(_ error: Error) -> AuthViewModelError {
        .service(error.localizedDescription)
    }
}
