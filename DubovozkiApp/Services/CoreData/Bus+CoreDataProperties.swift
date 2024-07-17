//
//  Bus+CoreDataProperties.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//
//

import Foundation
import CoreData

// MARK: - Bus model extension
extension Bus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bus> {
        let request = NSFetchRequest<Bus>(entityName: "Bus")
        request.returnsObjectsAsFaults = false
        return request
    }

    @NSManaged public var dayOfWeek: Int16
    @NSManaged public var dayTime: Int64
    @NSManaged public var dayTimeString: String?
    @NSManaged public var direction: String?
    @NSManaged public var id: Int16
    @NSManaged public var station: String?

}

extension Bus : Identifiable {

}
