//
//  Validator.swift
//  RegistrationForm
//
//  Created by Alexandr on 8/25/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import Foundation

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Необходим пароль")}
        guard value.count >= 6 else { throw ValidationError("Пароль должен содержать более 6 символов") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Пароль должен содержать более 6 символов, цифры и буквы. Введите повторно.")
            }
        } catch {
            throw ValidationError("Пароль должен содержать более 6 символов, цифры и буквы. Введите повторно.")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Неверный адрес электронной почты")
            }
        } catch {
            throw ValidationError("Неверный адрес электронной почты")
        }
        return value
    }
}

enum ValidatorType {
    case email
    case password
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        }
    }
}
