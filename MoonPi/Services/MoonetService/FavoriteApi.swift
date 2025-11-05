//
//  FavoriteApi.swift
//  MoonPi
//
//  Created by Gabriel Santos on 1/11/25.
//

final class FavoriteApi {
    static let shared = FavoriteApi()
    private let client: Client = .shared
    
    func add(url: String) async -> ApiResponse<Bool>? {
        return try? await client.sendRequest(
            endpoint: "/favorite",
            method: .POST,
            body: FavoriteAddRequest(url: url)
        )
    }
    
    func list(_ limit: Int8? = nil, _ page: Int8? = nil) async -> ApiResponse<VideoListResponse>? {
        var query: [String: String] = [:]
        if limit != nil {
            query["limit"] = String(limit!)
        }
        if page != nil {
            query["page"] = String(page!)
        }
        return try? await client.sendRequest(
            endpoint: "/favorite",
            method: .GET,
            query: query
        )
    }
    
    func remove(url: String) async -> ApiResponse<Bool>? {
        return try? await client.sendRequest(
            endpoint: "/favorite",
            method: .DELETE,
            query: ["url": url]
        )
    }
}
