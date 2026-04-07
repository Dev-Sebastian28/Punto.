//
//  AuthValidator.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/03/26.
//

import Foundation

enum ValidatorError: Error {
    case emptyFields
    case invalidEmail
    case passwordTooShort
    case passwordMissingNumber
    case passwordMissingSymbol
    case passwordMissingLowercase
    case passwordMissingUppercase

    var suggestion: String {
        switch self {
        case .emptyFields: return "Please fill all fields"
        case .invalidEmail: return "Please enter a valid email"
        case .passwordTooShort: return "Password must be at least 8 characters long"
        case .passwordMissingNumber: return "Password must contain a number"
        case .passwordMissingSymbol: return "Password must contain a symbol"
        case .passwordMissingLowercase: return "Password must contain a lowercase letter"
        case .passwordMissingUppercase: return "Password must contain an uppercase letter"
        }
    }
}


class AuthValidator {
    
    private static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", AuthValidator.emailRegex)
    
    func validate(email: String?, password: String?) throws {
        guard let email, !email.isEmpty else { throw ValidatorError.emptyFields }
        guard let password, !password.isEmpty else { throw ValidatorError.emptyFields }
        guard emailPredicate.evaluate(with: email) else { throw ValidatorError.invalidEmail }

        if password.count < 8 { throw ValidatorError.passwordTooShort }
        if !password.contains(where: { $0.isNumber }) { throw ValidatorError.passwordMissingNumber }
        if !password.contains(where: { $0.isSymbol }) { throw ValidatorError.passwordMissingSymbol }
        if !password.contains(where: { $0.isLowercase }) { throw ValidatorError.passwordMissingLowercase }
        if !password.contains(where: { $0.isUppercase }) { throw ValidatorError.passwordMissingUppercase }
    }
}



