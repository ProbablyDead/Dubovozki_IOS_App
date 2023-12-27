//
//  ScheduleModel.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//

import Foundation

// MARK: - Model protocol
protocol ModelProtocol {
    func getRawData(dataChanged: @escaping ([Bus]) -> Void) -> [Bus]?
}

// MARK: - Model class
class ScheduleModel: ModelProtocol {
    init(networkDataService: NetworkDataServiceProtocol) {
        Schedule.networkDataService = networkDataService
    }
    
    func getRawData(dataChanged: @escaping ([Bus]) -> Void) -> [Bus]? {
        Schedule.getRawData { newSchedule in
            dataChanged(newSchedule)
        }
    }
}
