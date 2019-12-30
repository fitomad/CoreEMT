//
//  BusLineDestination.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusLineDestination: Codable
{
    /// Identificador de la línea
    public private(set) var lineID: String
    /// Nombre
    public private(set) var name: String
    /// Cabecera a la que se dirige en este momento el autobús
    public private(set) var headersDescription: String
    /// Distance hasta la cabecera de destino
    public private(set) var disntaceToHeader: String
    /// Nombre legible para la cabecera
    public private(set) var headerDestination: String

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case lineID = "Label"
        case name = "line"
        case headersDescription = "Description"
        case disntaceToHeader = "distance"
        case headerDestination = "to"
    }
}