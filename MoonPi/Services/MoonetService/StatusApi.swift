//
//  Status.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

final class StatusApi {
    static let shared = StatusApi()
    private let client: Client = .shared
    
    func get() async -> ApiResponse<StatusResponse>? {
        return try? await client.sendRequest(
            endpoint: "/status",
            method: .GET
        )
    }
}
