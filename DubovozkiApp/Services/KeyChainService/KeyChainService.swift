//
//  File.swift
//  DubovozkiAppServer
//
//  Created by Илья Володин on 17.12.2023.
//

import Foundation

class KeyChainService: KeyChainServiceProtocol {
    private let currentUser: String = "currentUser"
    
    func save(idToken: String) {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: currentUser,
            kSecValueData as String: idToken.data(using: .utf8)!
        ]
        
        SecItemAdd(attributes as CFDictionary, nil)
    }
    
    func check() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: currentUser
        ]
        
        return SecItemCopyMatching(query as CFDictionary, nil) == noErr
    }
    
    func delete() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: currentUser
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
