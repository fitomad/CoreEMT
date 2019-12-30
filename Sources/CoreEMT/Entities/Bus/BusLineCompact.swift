//
//  BusLineCompact.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 19/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusLineCompact: Codable
{
    /// Identificador de la línea
    public private(set) var lineID: String
    /// Nombre
    public private(set) var name: String
    /// Nombre de la cabecera de *ida*
    public private(set) var headerA: String
    /// Nombre de la cabecera de *vuelta*
    public private(set) var headerB: String
    /// Distancia hasta la cabecera de destino
    public private(set) var distanceFromHeader: Int
    /// Tipo de jornada que comtempla esta información
    public private(set) var headerDestination: String

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case lineID = "line"
        case name = "label"
        case headerA = "nameA"
        case headerB = "nameB"
        case distanceFromHeader = "metersFromHeader"
        case headerDestination = "to"
    }
}