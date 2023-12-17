//
//  NetworkDataInitializer.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//

import Firebase

class FirebaseNetworkDataInitializer: NetworkDataInitializerProtocol {
    func configure() {
        FirebaseApp.configure()
    }
}
