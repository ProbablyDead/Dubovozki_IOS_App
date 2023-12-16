//
//  DataService.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 30.11.2023.
//

import Firebase
import FirebaseAuth
import GoogleSignIn

protocol LoginServiceProtocol {
    static func checkAuth() -> Bool
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func loginViaGoogle(presentingView: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func createAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) 
    func signOut()
}

class LoginService: LoginServiceProtocol {
    
    static func chooseError(error: Error) -> LoginNetworkError {
        switch error._code {
        case AuthErrorCode.userNotFound.rawValue:
            return LoginNetworkError.userNotFound
        case AuthErrorCode.invalidEmail.rawValue:
            return LoginNetworkError.invalidEmail
        case AuthErrorCode.wrongPassword.rawValue:
            return LoginNetworkError.wrongPassword
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return LoginNetworkError.emailExists
        default:
            return LoginNetworkError.networkError
        }
    }
    
    static func checkAuth() -> Bool {
        Firebase.Auth.auth().currentUser != nil
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Firebase.Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            if let error = error {
                completion(.failure(Self.chooseError(error:error)))
                return
            }
            
            completion(.success(()))
        })
    }
    
    func loginViaGoogle(presentingView: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
      GIDSignIn.sharedInstance.signIn(withPresenting: presentingView) { signInResult, error in
          if let error = error {
              completion(.failure(error))
              return
          }
          
          guard let idToken: String = signInResult?.user.idToken?.tokenString else {
              completion(.failure(error!))
              return
          }
          
          let accessToken: String = (signInResult?.user.accessToken.tokenString)!
          let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
          
          Firebase.Auth.auth().signIn(with: credential)
          
          completion(.success(()))
      }
    }
    
    func createAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(Self.chooseError(error:error)))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Firebase.Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(Self.chooseError(error:error)))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func signOut() {
        do {
            try Firebase.Auth.auth().signOut()
        } catch { return }
    }
    
}
