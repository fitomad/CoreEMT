//
//  ArrivalParameter.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 20/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal struct ArrivalParameter: Codable
{
    /// Idioma de la petición
    internal private(set) var culture: EMTCulture
    /// Mostrar o no datos de tiempos de llegada
    internal private(set) var showEstimations: String
    /// Mostrar o no incidentes que afetan a las líneas de esa parada
    internal private(set) var showIncidents: String
    /// Mostrar o no detalles de la parada.
    internal private(set) var showBusStopDetails: String

    /**
        Contruye un parámetro que pasaremos al *request* de 
        tiempos de llegada.

        - Parameters:
            - culture: Idioma en la que esperamos los datos
            - estimations: Solcitamos tiempos de llegada
            - incidentes: Queremos saber incidencias
            - busStopDetails: Detalles de la parada o no
    */
    internal init(culture: EMTCulture, includeEstimations estimations: Bool, incidents: Bool, busStopDetails: Bool)
    {
        self.culture = culture
        self.showEstimations = estimations ? "Y" : "N"
        self.showIncidents = incidents ? "Y" : "N"
        self.showBusStopDetails = busStopDetails ? "Y" : "N"
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case culture = "cultureInfo"
        case showEstimations = "Text_EstimationsRequired_YN"
        case showIncidents = "Text_IncidencesRequired_YN"
        case showBusStopDetails = "Text_StopRequired_YN"
    }
}
