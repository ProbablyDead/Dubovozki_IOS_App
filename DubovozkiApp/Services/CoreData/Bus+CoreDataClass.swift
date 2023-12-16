//
//  Bus+CoreDataClass.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//
//

import Foundation
import CoreData

public class Bus: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, day, dayTime, dayTimeString, direction, station
     }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
             throw DecoderConfigurationError.missingManagedObjectContext
           }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.day = try container.decode(Int16.self, forKey: .day)
        self.dayTime = try container.decode(Int64.self, forKey: .dayTime)
        self.dayTimeString = try container.decode(String.self, forKey: .dayTimeString)
        self.direction = try container.decode(String.self, forKey: .direction)
        self.station = try container.decode(String.self, forKey: .station)
    }
    
    public func encode(to encoder: Encoder) throws {
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(day, forKey: .day)
            try container.encode(dayTime, forKey: .dayTime)
            try container.encode(dayTimeString, forKey: .dayTimeString)
            try container.encode(direction, forKey: .direction)
            try container.encode(station, forKey: .station)
        }
    }

}
