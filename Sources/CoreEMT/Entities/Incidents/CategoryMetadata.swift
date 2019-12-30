//
//  CategoryMetadata.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 12/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public enum CategoryMetadata: Codable 
{
    /// Las líneas de autobús vienen en un `Array`
    case array([String])
    /// La línea de autobús viene en un `String`
    case string(String)

    // MARK: - Properties -

    public var busLines: [String]
    {
        switch self
        {
            case .array(let values):
                return values
            case .string(let value):
                return [ value ]
        }
    }

    // MARK: - Codable Protocol Implementation

    public init(from decoder: Decoder) throws 
    {
        let container = try decoder.singleValueContainer()
        
        do 
        {
            self = try .array(container.decode(Array.self))
        } 
        catch DecodingError.typeMismatch 
        {
            do 
            {
                self = try .string(container.decode(String.self))
            } 
            catch DecodingError.typeMismatch 
            {
                throw DecodingError.typeMismatch(CategoryMetadata.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }

    public func encode(to encoder: Encoder) throws 
    {
        var container = encoder.singleValueContainer()

        switch self 
        {
            case .array(let array):
                try container.encode(array)
            case .string(let string):
                try container.encode(string)
        }
    }
}