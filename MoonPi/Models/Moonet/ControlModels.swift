//
//  ControlModels.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

final class PlayResponse: StatusResponse {}

final class PauseResponse: StatusResponse {}

final class ResumeResponse: StatusResponse {}

final class StopResponse: StatusResponse {}

final class VolumeResponse: StatusResponse {}

final class PlayRequest: Encodable {
    let url: String?
    let query: String?
    let volume: Int8?
    
    init(url: String? = nil, query: String? = nil, volume: Int8? = nil) throws {
        if url == nil && query == nil {
            throw RequestError.missing(params: "url or query")
        }
        self.url = url
        self.query = query
        self.volume = volume
    }
}

final class VolumeRequest: Encodable {
    let value: Int8?
    let delta: Int8?
    
    init(value: Int8? = nil, delta: Int8? = nil) throws {
        if value == nil && delta == nil {
            throw RequestError.missing(params: "value or delta")
        }
        self.value = value
        self.delta = delta
    }
}
