//
//  Venue.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 13/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Venue: Codable
{
    /// Categoría
    public private(set) var category: String
    /// Idioma en el que viene la información
    public private(set) var language: String
    /// Código de familia
    public private(set) var familyCode: String
    /// Código de tipo
    public private(set) var typeCode: String
    /// Familia
    public private(set) var familyName: String
    /// Coordenas con la ubicación del lugar
    public private(set) var geometry: Geometry
    /// Número de teléfono de contacto del lugar turístico
    public private(set) var phoneNumber: String
    /// Código de categoría
    public private(set) var categoryCode: String
    /// Identificador de POI (Point Of Interest)
    public private(set) var poiIdentifier: String
    /// Dirección en la que se encuentra el lugar
    public private(set) var address: String
    /// Icono asociado al lugar
    public private(set) var venueIcon: URL
    /// Identificador único del lugar
    public private(set) var venueIdentifier: String
    /// Tipo
    public private(set) var typeName: String
    /// Nombre del lugar
    public private(set) var name: String

    private enum CodingKeys: String, CodingKey
    {
        case category
        case language
        case familyCode = "family"
        case typeCode
        case familyName
        case geometry
        case phoneNumber = "phone"
        case categoryCode
        case poiIdentifier = "idPoi"
        case address
        case venueIcon = "icon"
        case venueIdentifier = "_id"
        case typeName = "type"
        case name
    }
}