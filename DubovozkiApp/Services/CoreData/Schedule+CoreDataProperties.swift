//
//  Schedule+CoreDataProperties.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 07.12.2023.
//
//

import CoreData

// MARK: Check whether data is up-to date
extension Schedule : Identifiable {
    class func getRawData(dataChanged: @escaping ([Bus]) -> Void) -> [Bus]? {
        let data = Schedule.getRawDataFromCoreData()
        let currentSchedule = data.isEmpty ? nil : data.first
        
        Schedule.backgroundContext.perform {
            Schedule.networkDataService.getData { downloadedData in
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = Schedule.context
                let decodedDownloadedSchedule = try! decoder.decode(Schedule.self, from: downloadedData)
                if  currentSchedule?.revision ?? -1 < decodedDownloadedSchedule.revision {
                    Schedule.context.perform {
                        data.forEach {Schedule.deleteFromContext(schedule: $0) }
                        
                        Schedule.insertToContext(schedule: decodedDownloadedSchedule)
                        
                        Schedule.saveToContext()
                        dataChanged(decodedDownloadedSchedule.bus_list!.allObjects as! [Bus])
                    }
                }
            }
        }
        
        return currentSchedule?.bus_list!.allObjects as? [Bus]
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }

    @NSManaged public var revision: Int16
    @NSManaged public var bus_list: NSSet?
    
    class func getRawDataFromCoreData() -> [Schedule] {
        let request = Schedule.fetchRequest()
        request.returnsObjectsAsFaults = false
        return try! Schedule.context.fetch(request)
    }
    
    class func saveToContext() {
        try? context.save()
    }
    
    class func insertToContext(schedule: Schedule) {
        context.insert(schedule)
    }
    
    class func deleteFromContext(schedule: Schedule) {
        context.delete(schedule)
    }
}
