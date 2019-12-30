//
//  BusLineStops.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 07/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusLineStops: Codable
{
    /// Paradas de autobús devueltas para la petición
    /// de paradas de una línea de autobús.
    public private(set) var stops: [BusStopCompact]

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case stops
    }
}