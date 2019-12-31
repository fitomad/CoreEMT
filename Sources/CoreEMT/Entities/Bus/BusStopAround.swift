//
//  BusStopAround.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusStopAround: Codable
{
    /// Identificador de la parada
    public private(set) var stopID: Int
    /// Coordenada GPS
    public private(set) var geometry: Geometry
    /// Nombde
    public private(set) var name: String
    /// Distancia hasta el punto de origen de la búsqueda
    /// Puede ser una coordenada u otra parada
    public private(set) var distance: Int
    /// Líneas de autobús que paran aquí
    public private(set) var busLines: [BusLineCompact]

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case stopID = "stopId"
        case geometry
        case name = "stopName"
        case distance = "metersToPoint"
        case busLines = "lines"
    }
    
}