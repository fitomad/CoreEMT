//
//  Incident.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 31/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Incident: Codable
{
    /// Identificador único de la incidencia
    public private(set) var incidentIdentifier: String
    /// Título
    public private(set) var title: String
    /// Texto explicativo acerca de la incidencia
    public private(set) var description: String
    /// Recurso URI con más información 
    private var incidentURI: String
    /// Creador
    public private(set) var author: String
    /// Fecha de publicación
    private var publishedAtString: String
    /// Momento de inicio la incidencia
    private var startsAtString: String
    /// Cuando termina la incidencia
    private var endsAtString: String
    /// Código Google Transit de la incidencia
    public private(set) var googleCause: String
    /// Código Google Transit del efecto
    public private(set) var googleEffect: String
    /// Línes de autobús afectadas. Puede ser una (string) o varias (array)
    private var affectedBusLinesMetadata: CategoryMetadata
    /// Si hay un documento asociado a la incidencia
    public private(set) var associatedDocument: Enclosure?

    /// Fecha de publicación
    public var publishedAt: Date?
    {
        DateFormatter.feedFormatter.date(from: self.publishedAtString)
    }

    /// Fecha de inicio
    public var startsAt: Date?
    {
        DateFormatter.incidentFormatter.date(from: self.startsAtString)
    }

    /// Fecha de fin
    public var endsAt: Date?
    {
        DateFormatter.incidentFormatter.date(from: self.endsAtString)
    }

    /// Dirección URL de la incidencia
    public var incidentURL: URL?
    {
        return URL(string: self.incidentURI)
    }

    /// Líneas de autobús afectadas
    public var affectedBusLines: [String]
    {
        return self.affectedBusLinesMetadata.busLines
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case incidentIdentifier = "guid"
        case title
        case description 
        case incidentURI = "link"
        case author
        case publishedAtString = "pubDate"
        case startsAtString = "rssAfectaDesde"
        case endsAtString = "rssAfectaHasta"
        case googleCause = "GoogleTransitCause"
        case googleEffect = "GoogleTransitEffect"
        case affectedBusLinesMetadata = "category"
        case associatedDocument = "enclosure"
    }
}
