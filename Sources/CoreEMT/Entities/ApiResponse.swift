//
//  ApiResponse.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal struct ApiResponse<Element>: Codable where Element: Codable
{
    /// Código de respuesta del API
    internal private(set) var code: String
    /// Texto descriptivo del estado
    internal private(set) var responseStatus: String
    /// Los datos devueltos por la petición
    internal private(set) var result: Element 

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case code
        case responseStatus = "description"
        case result = "data"
    }
}