//
//  Family.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 14/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal struct Family: Codable
{
    /// Identicador de la familia (categoria) de los 
    /// lugares turísticos
    internal private(set) var familyIdentifier: String

    /**
        Una familia determinada.
    */  
    internal init(withIdentifier identifier: String)
    {
        self.familyIdentifier = identifier
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case familyIdentifier = "familyCode"
    }
}