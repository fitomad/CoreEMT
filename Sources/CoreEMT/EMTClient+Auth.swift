//
//  EMTClient+Auth.swift
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
        Validación del usuario registrado en el portal
        de desarrolladores del MobilityLabs de la EMT.        
    */
    public func login() -> AnyPublisher<ApiUser, Error>?
    {
        let stationsURI = "\(self.baseUri)/mobilitylabs/user/login/"

        let loginHeaders = [
            LoginParameter.userEmail(email: self.settings.userEmail),
            LoginParameter.password(pass: self.settings.password),
            LoginParameter.clientID(identifier: self.settings.clientID),
            LoginParameter.apiKey(key: self.settings.apiKey)
        ]

        guard let httpRequest = self.makeURLRequest(string: stationsURI, headers: loginHeaders) else
        {
            return nil
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .tryMap { output in
                return try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[ApiUser]>.self, decoder: self.jsonDecoder)
            .map { apiResponse in
                return apiResponse.result[0]
            }
            .eraseToAnyPublisher()

        return publisher
    }

    public func authenticate() -> Void
    {
        let stationsURI = "\(self.baseUri)/mobilitylabs/user/login/"

        let loginHeaders = [
            LoginParameter.userEmail(email: self.settings.userEmail),
            LoginParameter.password(pass: self.settings.password),
            LoginParameter.clientID(identifier: self.settings.clientID),
            LoginParameter.apiKey(key: self.settings.apiKey)
        ]

        guard let httpRequest = self.makeURLRequest(string: stationsURI, headers: loginHeaders) else
        {
            return
        }

        let publisher = self.httpSession.dataTaskPublisher(for: httpRequest)
            .receive(on: DispatchQueue.main)
            .tryMap { output in
                return try self.validateHttpResponse(data: output.data, response: output.response)
            }
            .decode(type: ApiResponse<[ApiUser]>.self, decoder: self.jsonDecoder)
            .map { apiResponse in
                return apiResponse.result[0].accessToken
            }
            .replaceError(with: "No-Token-Available")
            .print("authenticate()")
            .assign(to: \.accessToken, on: self)
            .store(in: &cancellableSet)
    }
}