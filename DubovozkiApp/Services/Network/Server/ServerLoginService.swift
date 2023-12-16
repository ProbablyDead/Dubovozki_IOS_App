//
//  File.swift
//  DubovozkiAppServer
//
//  Created by Илья Володин on 17.12.2023.
//

import Foundation
import UIKit

class ServerLoginService: LoginServiceProtocol {
    static func checkAuth() -> Bool {
        return true
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
    }
    
    func loginViaGoogle(presentingView: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
    }
    
    func createAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
    }
    
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
    }
    
    func signOut() {
    }
    
    
}
