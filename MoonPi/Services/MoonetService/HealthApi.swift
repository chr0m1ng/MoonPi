//
//  Health.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

final class Health {
    static let shared = Health()
    private let client: Client = .shared
    
    func get() async throws -> ApiResponse<HealthResponse>? {
        return try await client.sendRequest(
            endpoint: "/health",
            method: .GET
        )
    }
}
