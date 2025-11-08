//
//  SearchApi.swift
//  MoonPi
//
//  Created by Gabriel Santos on 5/11/25.
//

final class SearchApi {
    static let shared = SearchApi()
    private let client: Client = .shared
    
    func search(query: String, _ limit: Int8? = nil, _ page: Int8? = nil) async -> ApiResponse<VideoListResponse>? {
        var query: [String: String] = ["query": query]
        if limit != nil {
            query["limit"] = String(limit!)
        }
        if page != nil {
            query["page"] = String(page!)
        }
        return try? await client.sendRequest(
            endpoint: "/search",
            method: .GET,
            query: query
        )
    }
    
    func listHistory() async -> ApiResponse<[String]>? {
        return try? await client.sendRequest(
            endpoint: "/search/history",
            method: .GET
        )
    }
    
    func deleteFromHistory(query: String) async -> ApiResponse<Bool>? {
        return try? await client.sendRequest(
            endpoint: "/search/history",
            method: .DELETE,
            query: ["query": query]
        )
    }
}
