//
//  EMTClient+Bus.swift
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
        Paradas de autobús en un radio determinado de metros
        centrado en unas coordenadas

        - Parameters
            - latitude: Latitud del punto central
            - longitude: Longitud del punto central
            - radius: Radio de acción de la búsqueda
        - Returns: Publicamos un array de paradas o un error si lo hubiera
    */
    public func busStopsCentered(inLatitude latitude: Double, longitude: Double, radius: Int) -> AnyPublisher<[BusStopAround], Error>?
    {        
        let stationsURI = "\(self.baseUri)/transport/busemtmad/stops/arroundxy/\(latitude)/\(longitude)/\(radius)/"

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
            .decode(type: ApiResponse<[BusStopAround]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result
            }
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Paradas de autobús cercanas a una dada.

        Se parece a la función de búsqueda de paradas
        por localización pero en este caso el centro es 
        una parada.

        - Parameters:
            - stopID: Parada que hace de centro de la búsqueda
            - radius: Radio de acción
        - Returns: Publicamos un array de paradas encontradas o un error
    */
    public func busStopsAround(busStop stopID: Int, inside radius: Int) -> AnyPublisher<[BusStopAround], Error>?
    {
        let stationsURI = "\(self.baseUri)/transport/busemtmad/stops/arroundstop/\(stopID)/\(radius)/"

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
            .decode(type: ApiResponse<[BusStopAround]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result
            }
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Detalles de una parada de autobús.

        - Parameter stopID: Código de la parada.
        - Returns: Los detalles de la parada
    */
    public func busStopDetails(forBusStop stopID: Int) -> AnyPublisher<BusStop, Error>?
    {
        let stationsURI = "\(self.baseUri)/transport/busemtmad/stops/\(stopID)/detail/"

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
            .decode(type: ApiResponse<[BusStopResponse]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result[0].stops[0]
            }
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Tiempo de espera para una parada.

        - Parameter stopID: Identificador de la parada
        - Returns: Datos de llegada de los diferentes autobuses.
    */
    public func arrivals(forBusStop stopID: Int) -> AnyPublisher<ArrivalResponse, Error>?
    {
        let stationsURI = "\(self.baseUri)/transport/busemtmad/stops/\(stopID)/arrives/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken),
            CommonParameter.contentType(type: "application/json")
        ]

        let requestParameter = ArrivalParameter(culture: .spanish, 
            includeEstimations: true, 
            incidents: false, 
            busStopDetails: true)

        let requestBody = try? self.jsonEncoder.encode(requestParameter)

        guard let httpRequest = self.makeURLRequest(string: stationsURI, method: "POST", headers: requestHeaders, body: requestBody) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in 
                try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[ArrivalResponse]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result[0]
            }
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Detalles de una línea de autobús.

        - Parameter lineID: Identificador de la línea.
        - Returns: Los detalles de la línea.
    */
    public func busLinesAvailables() -> AnyPublisher<[BusLineRecord], Error>?
    {
        let linesURI = "\(self.baseUri)/transport/busemtmad/lines/info/\(DateFormatter.todayReferenceDate)/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: linesURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in 
                try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[BusLineRecord]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result
            }
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Detalles de una línea de autobús.

        - Parameter lineID: Identificador de la línea.
        - Returns: Los detalles de la línea.
    */
    public func busLineDetail(for lineID: Int) -> AnyPublisher<BusLineDetails, Error>?
    {
        let lineDetailURI = "\(self.baseUri)/transport/busemtmad/lines/\(lineID)/info/\(DateFormatter.todayReferenceDate)/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: lineDetailURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in 
                try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[BusLineDetails]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result[0]
            }
            .eraseToAnyPublisher()

        return publisher
    }

    /**
        Paradas que hace una línea de autobús en uno de los 
        dos sentidos de su ruta.

        - Parameters:
            - lineID: Identificador de la línea.
            - direction: Paradas en el sentido de *ida* o de *vuelta*
    */
    public func busLineStops(for lineID: Int, inDirection direction: Int) -> AnyPublisher<[BusStopCompact], Error>?
    {
        let lineDetailURI = "\(self.baseUri)/transport/busemtmad/lines/\(lineID)/stops/\(direction)/"

        let requestHeaders = [
            CommonParameter.accessToken(token: self.accessToken)
        ]

        guard let httpRequest = self.makeURLRequest(string: lineDetailURI, headers: requestHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in 
                try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[BusLineStops]>.self, decoder: self.jsonDecoder)
            .tryFilter { apiResponse in 
                try self.validateApiResponse(forCode: apiResponse.code)
            }
            .map { apiResponse in 
                return apiResponse.result[0].stops
            }
            .eraseToAnyPublisher()

        return publisher
    }
}