//
//  Enclosure.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 31/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Enclosure: Codable
{
    /// URI del dccumento asociado
    private var documentURI: String
    /// Tipo de archivo
    public private(set) var fileType: String
    /// Tamaño
    private var lenghtDescription: String

    /// Tamaño en formato entero
    public var length: Int
    {
        return Int(self.lenghtDescription)!
    }

    /// URL del documento si es que es válida
    public var documentURL: URL?
    {
        return URL(string: self.documentURI)
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case documentURI = "@url"
        case fileType = "@type"
        case lenghtDescription = "@length"
    }
}