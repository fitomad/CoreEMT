//
//  Parking.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 30/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Parking: Codable
{
    /// Nombre
    public private(set) var name: String
    /// Horario de uso público
    public private(set) var schedule: String?
    /// Nick del parking
    public private(set) var nick: String
    /// Puntos de acceso al parking
    public private(set) var access: [Access]
    /// Área administrativa donde se encuentra el parking
    public private(set) var administrativeArea: String
    /// Dirección postal donde se encuentra
    public private(set) var address: String
    /// Características de la que dispone
    public private(set) var features: [Feature]?

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case name
        case schedule
        case nick = "nickName"
        case access
        case administrativeArea
        case address
        case features
    }
}