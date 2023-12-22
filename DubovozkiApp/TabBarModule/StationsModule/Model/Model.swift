//
//  StationModel.swift
//  DubovozkiAppFirebase
//
//  Created by Илья Володин on 21.12.2023.
//

import UIKit

fileprivate enum RouteTypes: String {
    case odintsovoRoute = "Odintsovo"
    case molodezhnayaRoute = "Molodezhnaya"
    case slavyanskyRoute = "Slavyansky Blvd"
    
    var imageName: String {
        switch self {
        case .odintsovoRoute:
            "odintsovoEntry"
        case .molodezhnayaRoute:
            "molodezhnayaEntry"
        case .slavyanskyRoute:
            "slavyanskyBlvdEntry"
        }
    }
    
    var travelTime: Int {
        switch self {
        case .odintsovoRoute:
            15
        case .molodezhnayaRoute:
            30
        case .slavyanskyRoute:
            30
        }
    }
}

fileprivate enum StationTypes {
    case dubkiStation
    case dubkiToMldStation
    case odintsovoStation
    case slavyanskyStation
    case molodezhkaStation
    
    var name: String {
        switch self {
        case .dubkiStation, .dubkiToMldStation:
            "Dubki"
        case .odintsovoStation:
            "Odintsovo"
        case .slavyanskyStation:
            "Slavyansky Blvd"
        case .molodezhkaStation:
            "Molodezhnaya"
        }
    }
    
    var imageName: String {
        "ImageWillBeSoon"
    }
    
    var link: String {
        switch self {
        case .dubkiStation:
            "https://yandex.ru/maps/-/CDqwmCi5"
        case .dubkiToMldStation:
            "https://yandex.ru/maps/-/CDqwmK72"
        case .odintsovoStation:
            "https://yandex.ru/maps/-/CDqwmTN-"
        case .slavyanskyStation:
            "https://maps.yandex.com/?pt=37.475175,55.728993&z=17"
        case .molodezhkaStation:
            "https://yandex.ru/maps/-/CDqwqAiB"
        }
    }
}

struct Station {
    let name: String
    let imageName: String
    let linkToMaps: String
}

struct Route {
    let name: String
    let imageName: String
    
    let travelTime: Int
    
    let stationTo: Station
    let stationFrom: Station
}

extension Route {
    private static let to: String = "To "
    
    static let routes: [Route] = [
        Route(name: RouteTypes.slavyanskyRoute.rawValue,
              imageName: RouteTypes.slavyanskyRoute.imageName,
              travelTime: RouteTypes.slavyanskyRoute.travelTime,
              stationTo: Station(name: (to + StationTypes.slavyanskyStation.name).localized(),
                                 imageName: StationTypes.dubkiStation.imageName,
                                 linkToMaps: StationTypes.dubkiStation.link),
              stationFrom: Station(name: (to + StationTypes.dubkiStation.name).localized(),
                                   imageName: StationTypes.slavyanskyStation.imageName,
                                 linkToMaps: StationTypes.slavyanskyStation.link)),
        
        Route(name: StationTypes.molodezhkaStation.name,
              imageName: RouteTypes.molodezhnayaRoute.imageName,
              travelTime: RouteTypes.molodezhnayaRoute.travelTime,
              stationTo: Station(name: (to + StationTypes.molodezhkaStation.name).localized(),
                                 imageName: StationTypes.dubkiToMldStation.imageName,
                                 linkToMaps: StationTypes.dubkiToMldStation.link),
              stationFrom: Station(name: (to + StationTypes.dubkiStation.name).localized(),
                                   imageName: StationTypes.molodezhkaStation.imageName,
                                 linkToMaps: StationTypes.molodezhkaStation.link)),
        
        Route(name: StationTypes.odintsovoStation.name,
              imageName: RouteTypes.odintsovoRoute.imageName,
              travelTime: RouteTypes.odintsovoRoute.travelTime,
              stationTo: Station(name: (to + StationTypes.odintsovoStation.name).localized(),
                                 imageName: StationTypes.dubkiStation.imageName,
                                 linkToMaps: StationTypes.dubkiStation.link),
              stationFrom: Station(name: (to + StationTypes.dubkiStation.name).localized(),
                                   imageName: StationTypes.odintsovoStation.imageName,
                                 linkToMaps: StationTypes.odintsovoStation.link)),
    ]
}
