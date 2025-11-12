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
    
    static func from<F: Decodable>(json: String) -> F {
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(F.self, from: jsonData)
    }

}

class EmptyRequest: Encodable {}

enum RequestError: Error {
    case missing(params: String)
}

enum ConnectionError: Error {
    case invalidHostname
    case requestFailed(response: String)
}
