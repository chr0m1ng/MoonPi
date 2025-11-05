//
//  ControlApi.swift
//  MoonPi
//
//  Created by Gabriel Santos on 1/11/25.
//

final class ControlApi {
    static let shared = ControlApi()
    private let client: Client = .shared
    
    func pause() async -> ApiResponse<PauseResponse>? {
        return try? await client.sendRequest(
            endpoint: "/control/pause",
            method: .POST,
        )
    }
    
    func resume() async -> ApiResponse<ResumeResponse>? {
        return try? await client.sendRequest(
            endpoint: "/control/resume",
            method: .POST,
        )
    }
    
    func stop() async -> ApiResponse<StopResponse>? {
        return try? await client.sendRequest(
            endpoint: "/control/stop",
            method: .POST,
        )
    }
    
    func volume(value: Int8? = nil, delta: Int8? = nil) async -> ApiResponse<VolumeResponse>? {
        return try? await client.sendRequest(
            endpoint: "/control/volume",
            method: .POST,
            body: VolumeRequest(value: value, delta: delta)
        )
    }
    
    func play(url: String? = nil, query: String? = nil, volume: Int8? = nil) async -> ApiResponse<PlayResponse>? {
        return try? await client.sendRequest(
            endpoint: "/control/play",
            method: .POST,
            body: PlayRequest(url: url, query: query, volume: volume)
        )
    }
}
