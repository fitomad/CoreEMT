//
//  Timetable.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 07/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct Timetable: Codable
{
    /// Hora de inicio del serviucio
    public private(set) var startAt: String
    /// Hora de finalización del servicio
    public private(set) var endsAt: String
    /// Frecuencia mínima entre autobuses
    private var minimunFrequencyString: String
    /// Máxima frecuencia entre autbuses
    private var maximumFrequencyString: String
    /// Texto legible con las frecuencias
    public private(set) var frequencyDescription: String

    /// Frecuencia mínima en minutos
    public var minimunFrequency: Int
    {
        return Int(self.minimunFrequencyString) ?? 0
    }
 
    /// Frecuencia máxima en minutos
    public var maximumFrequency: Int
    {
        return Int(self.maximumFrequencyString) ?? 0
    }

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case startAt = "StartTime"
        case endsAt = "StopTime"
        case minimunFrequencyString = "MinimunFrequency"
        case maximumFrequencyString = "MaximumFrequency"
        case frequencyDescription = "FrequencyText"
    }
}