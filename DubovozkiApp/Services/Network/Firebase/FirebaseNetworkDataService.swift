//
//  NetworkDataService.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 06.12.2023.
//

import Firebase

// MARK: - Data service class
class FirebaseNetworkDataService: NetworkDataServiceProtocol {
    private enum Constants {
        static let childPathToData: String = "bus_schedule"
        static let labelOfQueue: String = "Dubovozki app"
    }
    
    func getData(completion: @escaping ((Data) -> Void)) {
        let queue = DispatchQueue(label: Constants.labelOfQueue)
        
        queue.async {
            let ref = Database.database().reference(withPath: Constants.childPathToData)
            
            ref.getData { error, snapshot in
                guard error == nil else {
                    return
                }
                
                guard let snapshot = snapshot else {
                    return
                }
                
                guard let value = snapshot.value else {
                    return
                }
                
                if let data = try? JSONSerialization.data(withJSONObject: value) {
                    completion(data)
                }
            }
        }
        
    }
}
