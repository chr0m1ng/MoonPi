//
//  Status.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

final class Status {
    static let shared = Status()
    private let client: Client = .shared
    
    func get() async throws -> ApiResponse<StatusResponse>? {
        return try await client.sendRequest(
            endpoint: "/status",
            method: .GET
        )
    }
}
