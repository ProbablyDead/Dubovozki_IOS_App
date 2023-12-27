//
//  Schedule+CoreDataClass.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//
//

import UIKit
import CoreData

// MARK: - Generated accessors for bus_list
extension Schedule {

    @objc(addBus_listObject:)
    @NSManaged public func addToBus_list(_ value: Bus)

    @objc(removeBus_listObject:)
    @NSManaged public func removeFromBus_list(_ value: Bus)

    @objc(addBus_list:)
    @NSManaged public func addToBus_list(_ values: NSSet)

    @objc(removeBus_list:)
    @NSManaged public func removeFromBus_list(_ values: NSSet)

}

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

@objc(Schedule)
public class Schedule: NSManagedObject, Codable {
    static var networkDataService: NetworkDataServiceProtocol?
    static let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
    static let context: NSManagedObjectContext = applicationDelegate.persistentContainer.viewContext
    static let backgroundContext: NSManagedObjectContext = applicationDelegate.backgroundContext
    
    enum CodingKeys: CodingKey {
        case bus_list, revision
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bus_list = try container.decode(Set<Bus>.self, forKey: .bus_list) as NSSet
        self.revision = try container.decode(Int16.self, forKey: .revision)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bus_list as! Set<Bus>, forKey: .bus_list)
        try container.encode(revision, forKey: .revision)
    }
    
}
