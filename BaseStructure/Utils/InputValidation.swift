//
//  InputValidation.swift
//  InputValidation
//
//  Created by Gaurang on 17/02/22.
//

import Foundation

typealias ValidationResult = (isValid: Bool, error: String?)

enum InputValidation {
    case email
    case password
    case mobile
    case name
    case nonEmpty
    case username
}

extension InputValidation {

    var maxLimit: Int {
        switch self {
        case .mobile:   return 10
        case .name:     return 25
        case .password: return 15
        default:        return 100
        }
    }

    var pattern: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,15}"
        case .username:
            return "^\\w{7,18}$"
        case .password:
            return "[a-zA-Z0-9!@#$%^&*]{8,15}"
        case .mobile:
            return "[0-9]{10}"
        case .name:
            return "[A-Za-z]{2,25}"
        case .nonEmpty:
            return ""
        }
    }

    func validate(input: String, field: String) -> ValidationResult {
        switch self {
        case .email:
            return InputValidation.validateEmail(input: input, field: field)
        case .password:
            return InputValidation.validatePassword(input: input, field: field)
        case .mobile:
            return InputValidation.validateMobile(input: input, field: field)
        case .name:
            return InputValidation.validateName(input: input, field: field)
        case .nonEmpty:
            return InputValidation.validateNoEmpty(input: input, field: field)
        case .username:
            return InputValidation.validateUsername(input: input, field: field)
        }
    }

    static func isValidForPattern(input: String, type: InputValidation) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type.pattern)
        return predicate.evaluate(with: input)
    }

}

// MARK: - Validation Methods
extension InputValidation {

    // MARK: - None Empty
    static func validateNoEmpty(input: String, field: String) -> ValidationResult {
        if input.isEmpty {
            return (false, "\(Messages.pleaseEnter) \(field)")
        } else {
            return (true, nil)
        }
    }

    // MARK: - Name
    static func validateName(input: String, field: String) -> ValidationResult {
        let emptyValidation = validateNoEmpty(input: input, field: field)
        guard emptyValidation.isValid else {
            return emptyValidation
        }
        guard input.count > 1 else {
            return (false, "Please enter minimum 2 characters in \(field).")
        }
        guard isValidForPattern(input: input, type: .name) else {
            return (false, "\(Messages.pleaseEnterValid) \(field)")
        }
        return (true, "")
    }

    // MARK: - Email
    static func validateEmail(input: String, field: String) -> ValidationResult {
        let emptyValidation = validateNoEmpty(input: input, field: field)
        guard emptyValidation.isValid else {
            return emptyValidation
        }
        guard isValidForPattern(input: input, type: .email) else {
            return (false, "\(Messages.pleaseEnterValid) \(field)")
        }
        return (true, "")
    }

    // MARK: - Mobile
    static func validateMobile(input: String, field: String) -> ValidationResult {
        let emptyValidation = validateNoEmpty(input: input, field: field)
        guard emptyValidation.isValid else {
            return emptyValidation
        }
        guard isValidForPattern(input: input, type: .mobile) else {
            return (false, "\(Messages.pleaseEnterValid) \(field)")
        }
        return (true, "")
    }

    // MARK: - UserName
   static func validateUsername(input: String, field: String) -> ValidationResult {
        let emptyValidation = validateNoEmpty(input: input, field: field)
        guard emptyValidation.isValid else {
            return emptyValidation
        }
        guard input.count >= 7 && input.count <= 18 else {
            return (false, Messages.invalidUsernameRange)
        }
       guard isValidForPattern(input: input, type: .username) else {
            return (false, "\(Messages.specialCharacterNotAllowed) \(field)")
        }
        return (true, "")
    }

    // MARK: - Password
    static func validatePassword(input: String, field: String) -> ValidationResult {
        let emptyValidation = validateNoEmpty(input: input, field: field)
        guard emptyValidation.isValid else {
            return emptyValidation
        }
        guard input.count >= 8 && input.count <= 25 else {
            return (false, Messages.invalidPasswordRange)
        }

        guard isValidForPattern(input: input, type: .password) else {
            return (false, "\(Messages.pleaseEnterValid) \(field)")
        }
        return (true, "")
        
    }

}

/*
 Usage:
 
 // MARK: - 1st Way
 let emailValidation = InputValidation.email.validate(input: "abc@xyz.com", field: "Email")
 
 // MARK: - 2nd way
 let emailValidation = InputValidation.validateEmail(input: "abc@xyz.com", field: "Email")
 
 if emailValidation.isValid {
     // email format is correct
 } else {
     print(emailValidation.error)
 }
 
 */
