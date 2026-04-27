//
//  AuthValidatorTests.swift
//  PuntoTests
//
//  Created by Sebastian Garcia on 27/04/26.
//

import Testing
@testable import Punto

enum EmailWrongCase: String, CaseIterable {
    case wrongEmail = "test.com"
    case wrongEmail2 = "test  @.com"
}

enum EmailRightCase: String, CaseIterable {
    case validEmail = "test@test.com"
    case validEmail2 = "test123@test.com"
    case validEmail3 = "test.lastname@test.com"
}

enum PasswordWrongCase: String, CaseIterable {
    case validPassword = "12dw678"
    case validPassword2 = "4567"
    case validPassword3 = "sebastian"
}

enum PasswordRightCase: String, CaseIterable {
    case validPassword = "Sebastian123$"
    case validPassword3 = "miContraseñaEsSegura123$"
}


@Suite("Authentication Validation Tests",.tags(.critical, .auth))
struct Authentication {
    let validator = AuthValidator()
    
    
    @Test("Email Validation - Success", arguments: EmailRightCase.allCases)
    func validateEmail(email: EmailRightCase) throws {
        let result = try validator.emailValidation(email: email.rawValue)
        #expect(result == true)
    }
    
    @Test("Email Validation - Failure ", arguments: EmailWrongCase.allCases)
    func validateEmailError(email: EmailWrongCase) {
        #expect(throws: ValidatorError.invalidEmail)  {
            try validator.emailValidation(email: email.rawValue)
        }
    }
    
    
    
    @Test("Password Validation - Success", arguments: PasswordRightCase.allCases)
    func passwordValidation(password: PasswordRightCase) throws {
        let result = try validator.passwordValidation(password: password.rawValue)
        #expect(result == true)
    }
    
    @Test("Password Validation - Failure", arguments: PasswordWrongCase.allCases)
    func passwordValidationError(password: PasswordWrongCase) {
        #expect(throws: ValidatorError.self) {
            try validator.passwordValidation(password: password.rawValue)
        }
    }
}
