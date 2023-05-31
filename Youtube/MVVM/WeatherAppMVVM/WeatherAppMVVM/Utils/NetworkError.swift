//
//  NetworkError.swift
//  WeatherAppMVVM
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case serializationFailed
    case generic
    case couldNotDecodeData
    case httpResponseError
    case statusCodeError = "Ocurrió un error al tratar de consultar el API: status code"
    case jsonDecoder = "Error al intentar extraer datos de json"
    case unauthorized
}
