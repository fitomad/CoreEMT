//
//  VenueType.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 13/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct VenueType: Codable
{
    /// Categoría a la que puede pertencer 
    /// un lugar turístico
    public private(set) var category: String
    /// Familia a la que pertenece
    public private(set) var family: String
    /// Codigo de tipo
    public private(set) var typeCode: String
    /// Código de familia
    public private(set) var familyCode: String
    /// Código de categoría
    public private(set) var categoryCode: String
    /// Icono asociado el lugar turístico
    public private(set) var icon: URL
    /// Nombre
    public private(set) var name: String
    
    private enum CodingKeys: String, CodingKey
    {
        case category
        case family
        case typeCode
        case familyCode
        case categoryCode
        case icon = "urlIcon"
        case name = "type"
    }
}