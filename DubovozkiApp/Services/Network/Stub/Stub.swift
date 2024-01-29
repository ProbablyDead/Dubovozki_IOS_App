//
//  Stub.swift
//  DubovozkiAppFirebase
//
//  Created by Илья Володин on 30.01.2024.
//

import UIKit

class Stub: LoginServiceProtocol {
    func checkAuth() -> Bool {
        true
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
