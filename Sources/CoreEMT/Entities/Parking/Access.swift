//
//  Access.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 30/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Access: Codable
{
    ///Coordenadas con la ubicación del parking
    public private(set) var location: Geometry
    /// Código del parking
    public private(set) var code: String
    /// Nombre
    public private(set) var name: String
    /// Dirección postal donde se encuentra
    public private(set) var address: String

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case location = "geometry"
        case code
        case name
        case address
    }
}