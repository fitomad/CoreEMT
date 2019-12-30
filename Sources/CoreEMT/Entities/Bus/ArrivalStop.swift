//
//  ArrivalStop.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 30/12/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct ArrivalStop: Codable
{
    /// Identificador único de la parada
    public private(set) var stopID: String
    /// Nombre de la parada
    public private(set) var name: String
    /// Localización (latitud/longitud) de la parada
    public private(set) var geometry: Geometry
    /// Dirección postal 
    public private(set) var address: String
    /// Líneas que pasan por esta parada
    public private(set) var busLines: [BusLineCompact]

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case stopID = "stopId"
        case name = "stopName"
        case geometry
        case address = "Direction"
        case busLines = "lines"
    }
}