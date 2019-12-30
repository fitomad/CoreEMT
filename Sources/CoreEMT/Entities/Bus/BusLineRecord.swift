//
//  BusLineRecord.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 02/12/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct BusLineRecord: Codable
{
    ///
    public private(set) var lineID: String
    ///
    public private(set) var name: String
    ///
    public private(set) var headerA: String
    ///
    public private(set) var headerB: String
    ///
    public private(set) var group: String
    ///
    private var availableSinceDate: String
    ///
    private var availableToDate: String

    ///
    public var availableSince: Date?
    {
        DateFormatter.emtShortFormatter.date(from: self.availableSinceDate)
    }

    ///
    public var availableTo: Date?
    {
        DateFormatter.emtShortFormatter.date(from: self.availableToDate)
    }
}
