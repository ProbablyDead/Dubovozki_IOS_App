//
//  NetworkDataInitializer.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//

import Firebase

// MARK: - Initializer for firebase
class FirebaseNetworkDataInitializer: NetworkDataInitializerProtocol {
    func configure() {
        FirebaseApp.configure()
    }
}
