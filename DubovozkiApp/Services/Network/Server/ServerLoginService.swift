//
//  File.swift
//  DubovozkiAppServer
//
//  Created by Илья Володин on 17.12.2023.
//

import Foundation
import UIKit

private extension ServerNetworkConstants {
    private static let auth: String = "auth/"
    
    static let loginUserString: String = hostname + auth + "signIn"
}

class ServerLoginService: LoginServiceProtocol {
    func checkAuth() -> Bool {
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
    
    func saveUser() {
        
    }
}
