//
//  BusStopResponse.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusStopResponse: Codable
{
    /// Paradas de autobús devueltas por la petición
    public private(set) var stops: [BusStop]

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case stops
    }
}