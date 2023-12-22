//
//  Filters.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 08.12.2023.
//

import Foundation

enum Filters {
    static let closeBusTime: Int64 = 1800000
    
    enum typeOfBus {
        case default_
        case close
        case passed
    }
    
    enum direction: String {
        case dbk = "dbk"
        case msk = "msk"
        
        var title: String {
            switch self {
            case .dbk: "to Dubki".localized()
            case .msk: "to Moscow".localized()
            }
        }
    }
    
    enum station: String, CaseIterable {
        case all = "all"
        case odn = "odn", slv = "slv", mld = "mld"
        
        var title: String {
            switch self {
            case .all: "All stations"
            case .odn: "Odintsovo"
            case .slv: "Slavyansky Blvd"
            case .mld: "Molodezhnaya"
            }
        }
    }
    
    enum date: Int, CaseIterable {
        case today = -1
        case tomorrow = -2
        case monday = 2
        case weekdays = 3
        case saturday = 7
        case sunday = 1
        
        private static var currentDay: Int {
            Calendar.current.component(.weekday, from: Date())
        }
        
        static var todayVar: Int {
            switch currentDay {
            case 1: return 1
            case 2: return 2
            case 3...6: return 3
            case 7: return 7
            default: return 3
            }
        }
        
        static var tomorrowVar: Int {
            let tomorrowInt = currentDay + 1
            switch tomorrowInt == 8 ? 1 : tomorrowInt {
            case 1: return 1
            case 2: return 2
            case 3...6: return 3
            case 7: return 7
            default: return 3
            }
        }
        
        var title: String {
            switch self {
            case .today: "Today"
            case .tomorrow: "Tomorrow"
            case .monday: "Monday"
            case .weekdays: "Weekdays"
            case .saturday: "Saturday"
            case .sunday: "Sunday"
            }
        }
    }
}
