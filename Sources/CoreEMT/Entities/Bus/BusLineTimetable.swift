//
//  BusLineTimetable.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 07/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusLineTimetable: Codable
{
    /// Tipo de día al que afecta este horario
    public private(set) var dayKind: DayKind
    /// Horario en sentido *ida*
    public private(set) var timetableHeaderA: Timetable
    /// Horario en sentido *vuelta*
    public private(set) var timetableHeaderB: Timetable

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case dayKind = "idDayType"
        case timetableHeaderA = "Direction1"
        case timetableHeaderB = "Direction2"
    }
}
