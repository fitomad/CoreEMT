//
//  Station.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Station: Codable
{
    /// Identificador único de la estación
    public private(set) var stationIdentifier: Int
    /// Nombre de la estación
    public private(set) var name: String
    /// Bivel de ocupación de bicis y docks
    public private(set) var ocupationLevel: OcupationLevel
    /// Número de la estación
    public private(set) var stationNumber: String
    /// Dirección postal donde se encuentra 
    public private(set) var address: String
    /// Si está activa
    private var activate: Int
    /// Si se encuentra disponible
    private var available: Int
    /// Cantidad de bases (docks) disponibles
    public private(set) var basesCount: Int
    /// Cantidad de bicis disponibles
    public private(set) var bikesDocked: Int
    /// Número de bases libres
    public private(set) var freeBases: Int
    /// Cantidad de reservas hechas en esa estación
    public private(set) var reservations: Int
    /// Coordenadas GPS de la estación
    public private(set) var geometry: Geometry

    /// Si la estación se encuentra operativa
    public var isAvailable: Bool
    {
        return (self.activate == 1) && (self.available == 1)
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case stationIdentifier = "id"
        case name
        case ocupationLevel = "light"
        case stationNumber = "number"
        case address
        case activate
        case available = "no_available"
        case basesCount = "total_bases"
        case bikesDocked = "dock_bikes"
        case freeBases = "free_bases"
        case reservations = "reservations_count"
        case geometry
    }
}
