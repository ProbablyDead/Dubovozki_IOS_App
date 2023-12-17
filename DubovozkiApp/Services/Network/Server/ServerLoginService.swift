//
//  File.swift
//  DubovozkiAppServer
//
//  Created by Илья Володин on 17.12.2023.
//

import GoogleSignIn
import UIKit

typealias Body = [String: String]

private extension ServerNetworkConstants {
    private static let auth: String = "auth/"
    
    static let signInString: String = hostname + auth + "signIn"
    static let signUpString: String = hostname + auth + "signUp"
    static let resetPasswordString: String = hostname + auth + "resetPassword"
}

class ServerLoginService: LoginServiceProtocol {
    func checkAuth() -> Bool {
        return false
    }
    
    private func saveUser(idToken: String) {
        print(idToken)
    }
    
    func loginViaGoogle(presentingView: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingView) { [weak self] signInResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let idToken: String = signInResult?.user.idToken?.tokenString else {
                completion(.failure(error!))
                return
            }
            
            self?.saveUser(idToken: idToken)
            
            completion(.success(()))
        }
    }
    
    private func sendRequest(link: String, body: Body, completion: @escaping (Result<Void, Error>) -> Void) {
        if let url = URL(string: link) {
            var request = URLRequest(url: url)
            request.addValue(ServerNetworkConstants.jsonContentTypeValue, forHTTPHeaderField: ServerNetworkConstants.contentType)
            request.httpMethod = ServerNetworkConstants.post
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch { return }
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let httpResponce = response as? HTTPURLResponse else { return }
                guard let responseData = data else { return }
                
                // error handeling
                guard (200...299).contains(httpResponce.statusCode) else {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                            let reason = String(describing: jsonResponse[ServerNetworkConstants.reason])
                            let regex = try NSRegularExpression(pattern: ServerNetworkConstants.pattern)
                            let range = NSRange(location: 0, length: reason.utf8.count)
                            
                            if let match = regex.firstMatch(in: reason, options: [], range: range) {
                                // Получение значения из найденной группы
                                let range = match.range(at: 1)
                                if let swiftRange = Range(range, in: reason) {
                                    if let error = LoginNetworkError.init(rawValue: String(reason[swiftRange])) {
                                        DispatchQueue.main.async {
                                            completion(.failure(error))
                                        }
                                    }
                                }
                            }
                        }
                    } catch { return }
                    return
                }
                
                if let idToken = String(data: responseData, encoding: .utf8) {
                    self?.saveUser(idToken: idToken)
                    completion(.success(()))
                }
            }
            
            task.resume()
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        sendRequest(link: ServerNetworkConstants.signInString, body: ["email": email, "password": password], completion: completion)
    }
    
    func createAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        sendRequest(link: ServerNetworkConstants.signUpString, body: ["email": email, "password": password], completion: completion)
    }
    
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        sendRequest(link: ServerNetworkConstants.resetPasswordString, body: ["email": email], completion: completion)
    }
    
    func signOut() {
    }
}
