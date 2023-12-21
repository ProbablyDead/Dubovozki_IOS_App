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
    
    var image: UIImage {
        UIImage()
    }
    
    var link: String {
        ""
    }
}

struct Station {
    let name: String
    let image: UIImage
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
              stationTo: Station(name: to + StationTypes.slavyanskyStation.name,
                                 image: StationTypes.dubkiStation.image,
                                 linkToMaps: StationTypes.dubkiStation.link),
              stationFrom: Station(name: to + StationTypes.odintsovoStation.name,
                                 image: StationTypes.slavyanskyStation.image,
                                 linkToMaps: StationTypes.slavyanskyStation.link)),
        
        Route(name: StationTypes.molodezhkaStation.name,
              imageName: RouteTypes.molodezhnayaRoute.imageName,
              travelTime: RouteTypes.molodezhnayaRoute.travelTime,
              stationTo: Station(name: to + StationTypes.molodezhkaStation.name,
                                 image: StationTypes.dubkiToMldStation.image,
                                 linkToMaps: StationTypes.dubkiToMldStation.link),
              stationFrom: Station(name: to + StationTypes.dubkiStation.name,
                                 image: StationTypes.molodezhkaStation.image,
                                 linkToMaps: StationTypes.molodezhkaStation.link)),
        
        Route(name: StationTypes.odintsovoStation.name,
              imageName: RouteTypes.odintsovoRoute.imageName,
              travelTime: RouteTypes.odintsovoRoute.travelTime,
              stationTo: Station(name: to + StationTypes.odintsovoStation.name,
                                 image: StationTypes.dubkiStation.image,
                                 linkToMaps: StationTypes.dubkiStation.link),
              stationFrom: Station(name: to + StationTypes.dubkiStation.name,
                                 image: StationTypes.odintsovoStation.image,
                                 linkToMaps: StationTypes.odintsovoStation.link)),
    ]
}
