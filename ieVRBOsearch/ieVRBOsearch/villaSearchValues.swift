//
//  villaSearchValues.swift
//  ieVRBOsearch
//
//  Created by Dustin Mahone on 2/25/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Foundation

struct villaSearchValues {

    struct searchValues {
        static var destination = ""
        static var arrivalDate = ""
        static var departureDate = ""
        static var minBed = ""
    }
    
    enum Endpoints {
        static let base = "https://www.vrbo.com/search/keywords:"
        static let town = "\(searchValues.destination)-the-bahamas"
        static let arrival = "/arrival:\(searchValues.arrivalDate)"
        static let departure = "/departure:\(searchValues.departureDate)"
        static let minBedrooms = "/minBedrooms/\(searchValues.minBed)?petIncluded=false&ssr=true"

        case villaSearch

        var stringValue: String {
            switch self {
            case .villaSearch: return Endpoints.base + Endpoints.town + Endpoints.arrival + Endpoints.departure + Endpoints.minBedrooms
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }

    }
}
