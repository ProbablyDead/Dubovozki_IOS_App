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
    
    var image: UIImage {
        switch self {
        case .odintsovoRoute:
            UIImage(named: "odintsovoEntry") ?? UIImage()
        case .molodezhnayaRoute:
            UIImage(named: "molodezhnayaEntry") ?? UIImage()
        case .slavyanskyRoute:
            UIImage(named: "slavyanskyBlvdEntry") ?? UIImage()
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
    private static let to: String = "To "
    
    static let routes: [Route] = [
        Route(name: RouteTypes.slavyanskyRoute.rawValue,
              image: RouteTypes.slavyanskyRoute.image,
              stationTo: Station(name: to + StationTypes.slavyanskyStation.name,
                                 image: StationTypes.dubkiStation.image,
                                 linkToMaps: StationTypes.dubkiStation.link),
              stationFrom: Station(name: to + StationTypes.odintsovoStation.name,
                                 image: StationTypes.slavyanskyStation.image,
                                 linkToMaps: StationTypes.slavyanskyStation.link)),
        
        Route(name: StationTypes.molodezhkaStation.name,
              image: RouteTypes.molodezhnayaRoute.image,
              stationTo: Station(name: to + StationTypes.molodezhkaStation.name,
                                 image: StationTypes.dubkiToMldStation.image,
                                 linkToMaps: StationTypes.dubkiToMldStation.link),
              stationFrom: Station(name: to + StationTypes.dubkiStation.name,
                                 image: StationTypes.molodezhkaStation.image,
                                 linkToMaps: StationTypes.molodezhkaStation.link)),
        
        Route(name: StationTypes.odintsovoStation.name,
              image: RouteTypes.odintsovoRoute.image,
              stationTo: Station(name: to + StationTypes.odintsovoStation.name,
                                 image: StationTypes.dubkiStation.image,
                                 linkToMaps: StationTypes.dubkiStation.link),
              stationFrom: Station(name: to + StationTypes.dubkiStation.name,
                                 image: StationTypes.odintsovoStation.image,
                                 linkToMaps: StationTypes.odintsovoStation.link)),
    ]
    
    let name: String
    let image: UIImage
    
    let stationTo: Station
    let stationFrom: Station
}

