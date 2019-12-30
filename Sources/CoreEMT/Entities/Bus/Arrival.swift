//
//  Arrival.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Arrival: Codable
{
    /**
        Tiempo estimado de llegada
    */
    public enum Estimation
    {
        /// Minutos
        case time(minutes: Int, seconds: Int)
        /// Más de 20 minutos
        case unknown
    }

    /// Identificador de la línea
    public private(set) var lineID: String
    /// Identificador de la parada
    public private(set) var stopID: String
    /// ¿La parada es cabecera de esta línea? 
    public private(set) var isHead: String
    /// Destino del autobús
    public private(set) var destination: String
    /// ¿...?
    public private(set) var deviation: Int
    /// Identificador único del autobús en la flota 
    public private(set) var busID: Int
    /// Posición GPS del autobús en el momento de la petición
    public private(set) var geometry: Geometry
    /// Tiempo estima de llegada a la parada
    private var estimateArrival: Int
    /// Distancia a la que se encuentra de la parada
    public private(set) var distance: Int
    /// ¿...?
    public private(set) var busPosition: String

    /// Estimación de tiempo de llegada
    public var estimateArrivalMinutes: Estimation
    {
        if self.estimateArrival == 999999 
        {
            return .unknown
        }

        let minutes = self.estimateArrival / 60
        let seconds = self.estimateArrival % 60

        return .time(minutes: minutes, seconds: seconds)
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case lineID = "line"
        case stopID = "stop"
        case isHead
        case destination
        case deviation
        case busID = "bus"
        case geometry
        case estimateArrival = "estimateArrive"
        case distance = "DistanceBus"
        case busPosition = "positionTypeBus"
    }
}