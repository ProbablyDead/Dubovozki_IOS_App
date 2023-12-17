//
//  ServerNetworkConstants.swift
//  DubovozkiAppServer
//
//  Created by Илья Володин on 17.12.2023.
//

enum ServerNetworkConstants {
    private static let protocolString: String = "http://"
    static let hostname: String = protocolString + "localhost:8080/"
    
    static let contentType: String = "Content-Type"
    static let defaultContentTypeValue: String = "application/x-www-form-urlencoded"
    static let jsonContentTypeValue: String = "application/json"
    
    static let get: String = "GET"
    static let post: String = "POST"
    
    static let reason: String = "reason"
    static let pattern: String = "\"message\": \"([^\"]+)\""
}
