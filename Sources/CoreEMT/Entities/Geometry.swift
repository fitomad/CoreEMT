//
//  Geometry.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Geometry: Codable
{
    /// Coordenadas devueltas por el API
    private var coordinates: [Double]

    /// Longitud. Es la primera posición en el array
    public var longitude: Double
    {
        return self.coordinates[0]
    }

    /// Latitud. Es la segunda posición en el array
    public var latitude: Double
    {
        return self.coordinates[1]
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case coordinates
    }
}