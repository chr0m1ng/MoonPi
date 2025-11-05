//
//  HistoryApi.swift
//  MoonPi
//
//  Created by Gabriel Santos on 1/11/25.
//

final class HistoryApi {
    static let shared = HistoryApi()
    private let client: Client = .shared
    
    func list(_ limit: Int8? = nil, _ page: Int8? = nil) async -> ApiResponse<VideoListResponse>? {
        var query: [String: String] = [:]
        if limit != nil {
            query["limit"] = String(limit!)
        }
        if page != nil {
            query["page"] = String(page!)
        }
        return try? await client.sendRequest(
            endpoint: "/history",
            method: .GET,
            query: query
        )
    }
    
    func clear() async -> ApiResponse<Bool>? {
        return try? await client.sendRequest(
            endpoint: "/history",
            method: .DELETE,
        )
    }
}
