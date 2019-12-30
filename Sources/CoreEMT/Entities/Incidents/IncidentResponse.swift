//
//  IncidentResponse.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 31/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct IncidentResponse: Codable
{
    /// Titulo del feed de incidencias
    public private(set) var title: String
    /// URL del feed
    public private(set) var feedURL: URL
    /// Descripción
    public private(set) var feedDescription: String
    /// Imagen asociada al feed
    public private(set) var image: FeedImage
    /// Derechos de autor
    public private(set) var copyright: String
    /// Quien es el webmaster
    public private(set) var webmaster: String?
    /// Cada cuanto se actualiza el feed
    public private(set) var refreshInterval: String
    /// Los incidentes que hay en el momento de la petición
    public private(set) var incidents: [Incident]

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case title
        case feedURL = "link"
        case feedDescription = "description"
        case image
        case copyright
        case webmaster = "webMaster"
        case refreshInterval = "ttl"
        case incidents = "item"
    }
}