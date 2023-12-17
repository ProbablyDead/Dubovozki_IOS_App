//
//  File.swift
//  DubovozkiAppServer
//
//  Created by Илья Володин on 17.12.2023.
//

import Foundation

private extension ServerNetworkConstants {
    private static let data: String = "data/"
    
    static let getData: String = hostname + data + "getData"
}

class ServerNetworkDataService: NetworkDataServiceProtocol {
    func getData(completion: @escaping ((Data) -> Void)) {
        if let url = URL(string: ServerNetworkConstants.getData) {
            var request = URLRequest(url: url)
            request.httpMethod = ServerNetworkConstants.get
            request.addValue(ServerNetworkConstants.defaultContentTypeValue, forHTTPHeaderField: ServerNetworkConstants.contentType)
            
            let task = URLSession.shared.dataTask(with: request) { data, responce, error in
                if let data = data {
                    completion(data)
                }
            }
            
            task.resume()
        }
    }
}
