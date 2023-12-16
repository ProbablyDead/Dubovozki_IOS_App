//
//  ScheduleModel.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//

import Foundation

protocol ModelProtocol {
    func getRawData(dataChanged: @escaping ([Bus]) -> Void) -> [Bus]?
}

class ScheduleModel: ModelProtocol {
    func getRawData(dataChanged: @escaping ([Bus]) -> Void) -> [Bus]? {
        Schedule.getRawData { newSchedule in
            dataChanged(newSchedule)
        }
    }
}
