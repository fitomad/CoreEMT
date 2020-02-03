//
//  ApiCounter.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal struct ApiCounter: Codable
{
    /// Número de peticiones hechas hasta ahora
    internal private(set) var current: Int
    /// Límite de peticiones al día.
    internal private(set) var dailyUse: Int
    /// De momento tiene valor 0
    internal private(set) var owner: Int

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case current
        case dailyUse
        case owner
    }
}
