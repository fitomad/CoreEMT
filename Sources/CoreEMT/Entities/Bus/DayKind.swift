//
//  DayKind.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 21/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public enum DayKind: String, Codable
{
    /// Laborables
    case workingDays = "LA"
    /// Sábado. Usado por los *buhos*
    case saturday = "SA"
    /// Festivos
    case holidays = "FE"
    /// Viernes
    case friday = "VI"
}