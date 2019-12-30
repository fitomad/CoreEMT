//
//  ParkingCompact.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct ParkingCompact: Codable
{
    /// Identificador del parking
    public private(set) var parkingID: Int
    /// Nombre
    public private(set) var name: String
    /// Dirección postal donde se encuentra
    public private(set) var address: String
    /// Código postal
    public private(set) var postalCode: String?
    /// Si está gestionado por la EMT
    public private(set) var operatedByEMT: Bool
    /// Cantidad de plazas libres
    public private(set) var freePlaces: Int?
    /// Coordenadas GPS del parking
    public private(set) var geometry: Geometry

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case parkingID = "id"
        case name
        case address
        case postalCode
        case operatedByEMT = "isEmtPark"
        case freePlaces = "freeParking"
        case geometry
    }
}