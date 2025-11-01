//
//  Status.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

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
