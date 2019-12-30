//
//  VenueResponse.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 13/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct VenueResponse: Codable
{
    /// Fuente de datos de la que se extrae la
    /// información turística
    public private(set) var source: String
    /// Lugares devueltos por la petición
    public private(set) var venues: [Venue]

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case source = "sourceName"
        case venues = "data"
    }

}