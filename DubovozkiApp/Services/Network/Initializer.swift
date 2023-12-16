//
//  NetworkDataInitializer.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//

import Firebase

protocol NetworkDataInitializerProtocol {
    func configure()
}

class NetworkDataInitializer: NetworkDataInitializerProtocol {
    func configure() {
        FirebaseApp.configure()
    }
}
