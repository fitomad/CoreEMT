//
//  CommonParameter.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 20/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal enum CommonParameter
{
    /// Token de acceso para las peticiones al API
    case accessToken(token: String)
    /// Tipo de contenido que enviamos (texto, json...)
    case contentType(type: String)
}

//
// MARK: - RequestValue Protocol -
//

extension CommonParameter: RequestValue
{
    /// Clave asociada
    internal var key: String
    {
        switch self
        {
            case .accessToken:
                return "accessToken"

            case .contentType:
                return "Content-Type"
        }
    }

    /// Valor asociado
    internal var value: String
    {
        switch self
        {
            case .accessToken(let token):
                return token

            case .contentType(let type):
                return type
        }
    }
}