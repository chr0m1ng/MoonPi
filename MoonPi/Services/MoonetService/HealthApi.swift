//
//  Health.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

final class HealthApi {
    static let shared = HealthApi()
    private let client: Client = .shared
    
    func get() async -> ApiResponse<HealthResponse>? {
        return try? await client.sendRequest(
            endpoint: "/health",
            method: .GET
        )
    }
}
