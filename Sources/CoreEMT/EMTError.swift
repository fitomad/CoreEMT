//
//  EMTError.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

public enum EMTError: Error
{
    /// Code 90
    case requestFailure
    /// Code 80
    case tokenExpired
    /// HTTP 404
    case malformedURL
    /// Error genérico
    case httpError
}