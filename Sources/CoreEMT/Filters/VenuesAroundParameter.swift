//
//  VenuesAroundParameter.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 14/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal struct VenuesAroundParameter: Codable
{
    /// Coordenadas de búsqueda de lugares turísticos
    internal private(set) var location: Coordinate
    /// Categorías que lugares incluidas en la petición
    internal private(set) var families: [Family]

    /**
        Parámetro que enviamos al API para que nos
        devuelva los lugares turísticos de englobados en unas
        categorías determinadas y centrados en un lugar 
        específico.
    */
    internal init(at coordinates: Coordinate, for families: [Family])
    {
        self.location = coordinates
        self.families = families
    }
    
    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case location = "coordinates"
        case families = "family"
    }
}
