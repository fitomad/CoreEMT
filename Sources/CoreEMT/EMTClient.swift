//
//  EMTClient.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Combine
import Foundation

public class EMTClient
{
    /**

    */
    internal struct Settings
    {
        ///
        internal let userEmail: String
        ///
        internal let password: String
        ///
        internal let clientID: String
        ///
        internal let apiKey: String

        /**
            Para obtener las credenciales necesarias para operar
            con el API de la EMT Madrid MobilityLabs debes 
            dirigirte a la [web de desarrolladores](https://mobilitylabs.emtmadrid.es/).

            Una vez allí ve a la sección **Portal de Desarrolladores**
            para acceder o crear una nueva cuenta de API para tu app.
        */
        internal init()
        {
            #error("Email con el que accedes al portal de desarrolladores")
            self.userEmail = ""
            #error("Contraseña con la que accedes al portal de desarrolladores")
            self.password = ""
            #error("Identificador de cliente (Client-ID) para tu app")
            self.clientID = ""
            #error("Clave de API para tu app")
            self.apiKey = ""
        }
    }

    /// Singleton
    public static let shared = EMTClient()

    /// Base para las peticiones al API de EMT Mobility Labs
    internal let baseUri = "https://openapi.emtmadrid.es/v1"

    /// Configuración para la conexión al API
    internal let settings: Settings
    /// Token de acceso al API para una sesión
    internal var accessToken: String

    /// Parser de JSON
    internal private(set) var jsonDecoder: JSONDecoder
    internal private(set) var jsonEncoder: JSONEncoder

    /// HTTP session...
    internal private(set) var httpSession: URLSession
    /// ...his configuration...
    private var httpConfiguration: URLSessionConfiguration
    /// ...and his queue associated.
    private var httpQueue: OperationQueue

    ///
    internal var cancellableSet: Set<AnyCancellable> = []

    /**
        Creamos un cliente para el API de la 
        EMT Madrid Mobility Labs.

        Por defecto permitimos **5 peticiones simultaneas**.
    */
    private init()
    {
        self.settings = Settings()
        self.accessToken = ""

        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.emtFormatter)

        self.jsonEncoder = JSONEncoder()

        self.httpConfiguration = URLSessionConfiguration.default
        self.httpConfiguration.httpMaximumConnectionsPerHost = 5
        
        self.httpQueue = OperationQueue()
        self.httpQueue.maxConcurrentOperationCount = 5
        
        self.httpSession = URLSession(configuration: self.httpConfiguration,
                                      delegate: nil,
                                      delegateQueue: self.httpQueue)
    }

    /**
        Genera una `URLRequest` a partir de una URL y los parámetros
        para la cabecera y el cuerpo de la petición.

        - Parameters:
            - string: La URL que debemos interrogar
            - method: La operación HTTP que ejecutamos. Puede ser `GET` o `POST`
            - headers: La cabera a incluir en la petición
            - body: El cuerpo de la petición
        - Returns: Un `URLRequest` si se ha podido crear en base a los parámetros.
    */
    internal func makeURLRequest(string uri: String, method: String = "GET", headers: [RequestValue]? = nil, body: Data? = nil) -> URLRequest?
    {
        guard let apiURL = URL(string: uri) else
        {
            return nil
        }

        var request = URLRequest(url: apiURL)
        request.httpMethod = method

        // Cabeceras de la petición
        if let headers = headers
        {
            for header in headers
            {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        // Cuperpo de la petición
        if let body = body
        {
            request.httpBody = body            
        }
        
        return request
    }  

    /**
        Comprueba si el resultado de una petición HTTP 
        ha terminao bien y en caso de ser así devolvemos
        los datos que tiene esa petición.

        - Parameters:
            - data: El contenido de la petición.
            - response: La respuesta del servidor.
        - Throws:
            - httpError: La petición ha fallado.
    */
    internal func validateHttpResponse(data: Data, response: URLResponse) throws -> Data
    {
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw EMTError.httpError
        }

        return data
    }

    /**
        Comprueba si el código devuelto por el sevidor 
        de la EMT es el de una petición correcta o por el 
        contrario si ha habido algún problema.

        Esta versión del API no usa los código HTTP para
        indicar el resultado de las peticiones, sino que usa
        el campo `code` de la respuesta para establecer el
        resultado. **Todas las peticiones tienen un código de 
        estado HTTP de 200**

        Los códigos devueltos son:

        + 80. Token no válido o que ha expirado.
        + 90. Problema con la petición
        + 00. Éxito

        - Parameter code: El código que vienen en el campo `code` de la respuesta
        - Returns: Si la petición ha sido exitosa o no.
        - Throws: 
            - accessToken: El token no vale
            - requestFailure: la petición es erronea
    */
    internal func validateApiResponse(forCode code: String) throws -> Bool
    {
        var isValid = true
        var throwError = false

        let semaphore = DispatchSemaphore(value: 0)

        if code == "80"
        {
            let publisher = self.login()?
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {
                        print(error.localizedDescription)
                    }
                },
                receiveValue: { apiUser in 
                    self.accessToken = apiUser.accessToken
                    throwError = true

                    semaphore.signal() 
                }
            )
        }
        else if code == "90"
        {
            isValid = false
            semaphore.signal()
        }
        else if code == "00" || code == "01"
        {
            semaphore.signal()
        }

        semaphore.wait()

        if throwError
        {
            throw EMTError.tokenExpired
        }

        return isValid
    }
}
