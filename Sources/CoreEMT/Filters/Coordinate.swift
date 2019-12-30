//
//  Coordinate.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 14/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal struct Coordinate: Codable
{
    /// Longitud
    internal private(set) var longitude: Double
    /// Latitud
    internal private(set) var latitude: Double
    /// Radio de acción
    internal private(set) var radius: Int

    /**
        Nueva coordenada geográfica con radio 
        de acción determinado.
    */
    internal init(longitude: Double, latitude: Double, around radius: Int)
    {
        self.longitude = longitude
        self.latitude = latitude
        self.radius = radius
    }
}