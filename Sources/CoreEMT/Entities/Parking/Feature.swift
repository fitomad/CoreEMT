//
//  Feature.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 30/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Feature: Codable
{
    /// Código de la caracterñistica
    public private(set) var code: String
    /// Nombre
    public private(set) var name: String
    /// Descripción
    public private(set) var content: String
    /// Nombre legible para el usuario
    public private(set) var fieldName: String

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case code
        case name
        case content
        case fieldName = "nameField"
    }
}