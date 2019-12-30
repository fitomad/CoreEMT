//
//  EMTClient+BiciMAD.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Combine
import Foundation

extension EMTClient
{
    /**
        Recupera todas las estaciones de BiciMAD.

        - Returns: Un array con las estaciones disponibles
    */
    public func bicimadStations() -> AnyPublisher<[Station], Error>?
    {
        let stationsURI = "\(self.baseUri)/transport/bicimad/stations/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: stationsURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { try self.validateHttpResponse(data: $0.data, response: $0.response) }
            .decode(type: ApiResponse<[Station]>.self, decoder: self.jsonDecoder)
            .tryFilter { try self.validateApiResponse(forCode: $0.code) }
            .map { $0.result }
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Recupera los datos de **una única** estación

        - Parameter name stationIdentifier: El código de la estación
        - Returns: Información de la estación solicitada.
    */
    public func bicimadStation(identifier stationIdentifier: Int) -> AnyPublisher<Station, Error>?
    {
        let stationsURI = "\(self.baseUri)/transport/bicimad/stations/\(stationIdentifier)/"

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
            .decode(type: ApiResponse<[Station]>.self, decoder: self.jsonDecoder)
            //
            .tryFilter { 
                try self.validateApiResponse(forCode: $0.code)
            }
            //
            .map { return $0.result[0] }
            .eraseToAnyPublisher()

        return publisher
    }
}