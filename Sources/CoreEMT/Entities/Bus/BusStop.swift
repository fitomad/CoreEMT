//
//  BusStop.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusStop: Codable
{
    /// Identificador de la parada
    public private(set) var stopID: String
    /// Nombre
    public private(set) var name: String
    /// Dirección postal donde se encuentra la parada
    public private(set) var address: String
    /// Coordenadas GPS de la parada
    public private(set) var geometry: Geometry
    /// Identificador del panel de información de la parada, si lo tiene
    public private(set) var electronicPanelID: String?
    /// Líneas de autobús que paran aquí
    public private(set) var busLines: [BusLine]

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case stopID = "stop"
        case name
        case address = "postalAddress"
        case geometry
        case electronicPanelID = "pmv"
        case busLines = "dataLine"
    }
}