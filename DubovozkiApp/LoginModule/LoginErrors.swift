//
//  LoginErrors.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 12.12.2023.
//

enum LoginNetworkError: Error {
    case userNotFound
    case emailExists
    case invalidEmail
    case wrongPassword
    case networkError
    
    var value: String {
        switch self {
        case .userNotFound:
            "EMAIL_NOT_FOUND"
        case .emailExists:
            "EMAIL_EXISTS"
        case .invalidEmail:
            "INVALID_EMAIL"
        case .wrongPassword:
            "INVALID_PASSWORD"
        case .networkError:
            "NETWORK_ERROR"
        }
    }
}
