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

class HealthResponse: Decodable {
}

class StatusResponse: Decodable {
    let pause: Bool
    let volume: Double
    let timePos: String?
    let duration: String?
    let mediaTitle: String?
    let playing: Bool
    let meta: Meta?
    
    private enum CodingKeys : String, CodingKey {
        case pause, volume, timePos = "time-pos", duration
        case mediaTitle = "media-title", playing, meta
    }
    
    class Meta: Decodable {
        let thumbnail: String
        let id: String
        let channel: String
        let url: String
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pause = try container.decode(Bool.self, forKey: .pause)
        self.volume = try container.decode(Double.self, forKey: .volume)
        self.timePos = try container.decodeIfPresent(String.self, forKey: .timePos)
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.mediaTitle = try container.decodeIfPresent(String.self, forKey: .mediaTitle)
        self.playing = try container.decode(Bool.self, forKey: .playing)
        self.meta = try container.decodeIfPresent(Meta.self, forKey: .meta)
    }
}

class EmptyRequest: Codable {
    
}
