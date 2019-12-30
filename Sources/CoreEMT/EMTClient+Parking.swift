//
//  EMTClient+Parking.swift
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
        Todos los parkings **con plazas libres**
        en el momento de la petición.
    */
    public func parkings() -> AnyPublisher<[ParkingCompact], Error>?
    {
        let stationsURI = "\(self.baseUri)/citymad/places/parkings/availability/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: stationsURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in
                return try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[ParkingCompact]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in
                //
                return apiResponse.result
            } 
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Detalles de un parking en concreto
    */
    public func parking(withIdenfifier identifier: Int) -> AnyPublisher<Parking, Error>?
    {
        let stationsURI = "\(self.baseUri)/citymad/places/parking/\(identifier)/es/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: stationsURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in 
                return try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[Parking]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result[0]
            }
            .eraseToAnyPublisher()

        return publisher
    }
}