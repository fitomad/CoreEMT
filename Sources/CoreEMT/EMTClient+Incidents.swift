//
//  EMTClient+Incidents.swift
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
        Todas las incidencias en el servicio de autobuses.

        - Returns: Un array con las incidencias
    */
    public func busServiceIncidents() -> AnyPublisher<[Incident], Error>?
    {
        let allIncidentsURI = "\(self.baseUri)/transport/busemtmad/lines/incidents/all/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: allIncidentsURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in 
                try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[IncidentResponse]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result[0].incidents
            }
            .eraseToAnyPublisher()

        return publisher    
    }

    /**
        Incidencias en el servicio para una línea en concreto

        - Returns: Las incidencias de la línea, si las hay
    */
    public func busServiceIncidents(forLine lineID: Int) -> AnyPublisher<[Incident], Error>?
    {
        let allIncidentsURI = "\(self.baseUri)/transport/busemtmad/lines/incidents/\(lineID)/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: allIncidentsURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in 
                try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[IncidentResponse]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result[0].incidents
            }
            .eraseToAnyPublisher()

        return publisher
    }
}