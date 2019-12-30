//
//  LoginParameter.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal enum LoginParameter
{
    /// Email del desarrollador regitrado
    case userEmail(email: String)
    /// Contraseña del desarrollador
    case password(pass: String)
    /// ClientID asociado para la app
    case clientID(identifier: String)
    /// Clave de API para la app
    case apiKey(key: String)
}

//
// MARK: - RequestValue Protocol - 
//

extension LoginParameter: RequestValue 
{
    ///
    internal var key: String
    {
        switch self
        {
            case .userEmail:
                return "email"
            case .password:
                return "password"
            case .clientID:
                return "X-ClientId"
            case .apiKey:
                return "X-ApiKey"
        }
    }

    ///
    internal var value: String
    {
        switch self
        {
            case .userEmail(let email):
                return email
            case .password(let pass):
                return pass
            case .clientID(let identifier):
                return identifier
            case .apiKey(let key):
                return key
        }
    }
}