//
//  Status.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

import Foundation

class StatusResponse: Decodable {
    let pause: Bool
    var volume: Int8
    var timePos: Double
    let duration: Double
    let mediaTitle: String
    let playing: Bool
    let idleActive: Bool
    let meta: Meta?
    
    internal class Meta: Decodable {
        let thumbnail: String
        let id: String
        let channel: String
        let url: String
    }
    
    static var empty: StatusResponse {
        let jsonString = """
            {
                "pause": false,
                "volume": 0,
                "time_pos": 0,
                "duration": 0,
                "playing": false,
                "media_title": "",
                "idle_active": true
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(StatusResponse.self, from: jsonData)
    }
}
