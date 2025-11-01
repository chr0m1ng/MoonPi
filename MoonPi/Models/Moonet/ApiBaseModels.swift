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
    
    private enum CodingKeys: String, CodingKey {
        case ok, data, error
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ok = try container.decode(Bool.self, forKey: .ok)
        self.data = try container.decodeIfPresent(T.self, forKey: .data)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
    }
}

class EmptyRequest: Codable {
    
}
