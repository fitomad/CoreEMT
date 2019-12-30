//
//  FeedImage.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 31/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

public struct FeedImage: Codable
{
    /// Título de la imagen
    public private(set) var title: String
    /// URL de la imagen
    public private(set) var imageURL: URL
    /// Enlace 
    public private(set) var imageLink: URL
    /// Texto descriptivo de la imagen si lo hubiera
    public private(set) var description: String?

    /**

    */
    private enum CodingKeys: String, CodingKey
    {
        case title
        case imageURL = "url"
        case imageLink = "link"
        case description
    }
}