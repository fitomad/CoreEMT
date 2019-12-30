//
//  ApiUser.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct ApiUser: Codable
{
    /// Última actualización de la información del desarrollador
    internal private(set) var updatedAt: Date
    /// Nombre de usuario 
    internal private(set) var userName: String
    /// Token de acceso. Es el que pasamos en cada petición al API
    internal private(set) var accessToken: String
    /// Cuando caduca el token
    internal private(set) var tokenExpiration: Int
    /// Correo electrónico del desarrollador
    internal private(set) var email: String
    /// Identificador de usuario.
    internal private(set) var userID: String
    /// Estadísticas de uso del API
    internal private(set) var counterInformation: ApiCounter

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case updatedAt
        case userName
        case accessToken
        case tokenExpiration = "tokenSecExpiration"
        case email
        case userID = "idUser"
        case counterInformation = "apiCounter"
    }
}