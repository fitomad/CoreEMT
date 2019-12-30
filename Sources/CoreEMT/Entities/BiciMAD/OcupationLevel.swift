//
//  OcupationLevel.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public enum OcupationLevel: Int, Codable
{
    /// Muy pocas bicis libres y muchos docks disponibles.
    case low = 0
    /// La mitad de la bicis y la mitad de los docks disponibles
    case medium = 1
    /// Disponibles muchas bicis. Pocos docks libres
    case high = 2
    /// Disponibles todas las bicis. Ninguna dock libre
    case full = 3
}