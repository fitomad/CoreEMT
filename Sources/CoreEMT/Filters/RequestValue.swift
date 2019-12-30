//
//  RequestValue.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 22/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal protocol RequestValue
{
    /// Clave del parámetro de la petición
    var key: String { get }
    /// Valor del parámetro de la petición
    var value: String { get }
}