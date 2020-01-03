//
//  ArrivalResponse.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct ArrivalResponse: Codable
{
    /// Información de tiempos de espera que devuelve 
    /// la petición de llegas para una parada.
    public private(set) var arrivals: [Arrival]
    /// Detalles de las paradas, si hubiera más de una
    public private(set) var stops: [ArrivalStop]

    /// El API devuelve un array de paradas,
    /// pero sólo queremos detalles de la primera
    public var stopDetails: ArrivalStop
    {
        return self.stops[0]
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case arrivals = "Arrive"
        case stops = "StopInfo"
    }
}
