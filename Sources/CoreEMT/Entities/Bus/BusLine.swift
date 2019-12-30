//
//  BusLine.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusLine: Codable
{
    /// Identificador de la línea
    public private(set) var lineID: String
    /// Nombre
    public private(set) var name: String
    /// Nombre de la cabecera a la que se dirige
    public private(set) var direction: String
    /// Frecuencia máxima entre autobuses para esta línea
    /// en esta dirección
    public private(set) var maxFrequency: String
    /// Frecuencia mínima entre autobuses para esta línea
    /// en esta dirección
    public private(set) var minFrequency: String
    /// Nombre de la cabecera de *ida*
    public private(set) var headerA: String
    /// Nombre de la cabecera de *vuelta*
    public private(set) var headerB: String
    /// Hora de inicio del servicio
    public private(set) var startTime: String
    /// Hora de fina de servicio de la línea
    public private(set) var endTime: String
    /// Tipo de jornada que comtempla esta información
    public private(set) var dayKind: DayKind

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case lineID = "line"
        case name = "label"
        case direction
        case maxFrequency = "maxFreq"
        case minFrequency = "minFreq"
        case headerA
        case headerB
        case startTime
        case endTime = "stopTime"
        case dayKind = "dayType"
    }
}