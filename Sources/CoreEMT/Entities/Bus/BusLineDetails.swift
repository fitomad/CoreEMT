//
//  BusLineDetails.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 07/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusLineDetails: Codable
{
    /// Identificador de la línea
    public private(set) var lineID: String
    /// Nombre
    public private(set) var name: String
    /// Nombre de la cabecera de *ida*
    public private(set) var headerA: String
    /// Nombre de la cabecera de *vuelta*
    public private(set) var headerB: String
    /// Horarios para esta línea de autobús
    public private(set) var timetables: [BusLineTimetable]

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case lineID = "line"
        case name = "label"
        case headerA = "nameA"
        case headerB = "nameB"
        case timetables = "timeTable"

    }
}