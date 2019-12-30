//
//  EMTClient+Tourism.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 13/11/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Combine
import Foundation

extension EMTClient
{
    /**
        Diferentes tipos de hitos turísticos
    */
    public func placeTypes(translatedTo culture: String) -> AnyPublisher<[VenueType], Error>?
    {
        let stationsURI = "\(self.baseUri)/citymad/places/types/\(culture)/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: stationsURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in
                try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[VenueType]>.self, decoder: self.jsonDecoder)
            //
            .tryFilter { 
                try self.validateApiResponse(forCode: $0.code)
            }
            //
            .map { return $0.result }
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Lugares de interés turístico alrededor de unas coordenadas
        geográficas dentro de radio determinado.

        La información se en castellano o traducida al inglés.

        - Parameters:
            - latitude: Latitud del centro de búsqueda.
            - longitude: Longitud del centro de búsqueda.
            - radius: Radio de acción de la búsqueda.
            - culture: Idioma en el que queremos la respuesta. Por defecto en castellano
    */
    public func placesAround(latitude: Double, longitude: Double, inRadius radius: Int, translatedTo culture: EMTCulture = .spanish) -> AnyPublisher<[Venue], Error>?
    {
        let venuesAroundURI = "\(self.baseUri)/citymad/places/arroundxy/\(culture.rawValue)/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken),
            CommonParameter.contentType(type: "application/json")
        ]

        let location = Coordinate(longitude: longitude, latitude: latitude, around: radius)
        let families = [ Family(withIdentifier: "101") ]
        let requestParameter = VenuesAroundParameter(at: location, for: families)

        let requestBody = try? self.jsonEncoder.encode(requestParameter)

        guard let httpRequest = self.makeURLRequest(string: venuesAroundURI, method: "POST", headers: requestHeaders, body: requestBody) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in 
                try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[VenueResponse]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result[0].venues
            }
            .eraseToAnyPublisher()

        return publisher
    }
}