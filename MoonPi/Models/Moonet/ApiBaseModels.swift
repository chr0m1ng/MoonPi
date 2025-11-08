//
//  MoonetModels.swift
//  MoonPi
//
//  Created by Gabriel Santos on 30/10/25.
//

import Foundation

class ApiResponse<T: Decodable>: Decodable {
    let ok: Bool
    let data: T?
    let error: String?
}

class EmptyRequest: Encodable {}

enum RequestError: Error {
    case missing(params: String)
}

enum ConnectionError: Error {
    case invalidHostname
    case requestFailed(response: String)
}
