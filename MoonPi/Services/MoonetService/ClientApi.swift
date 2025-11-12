//
//  Client.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import Foundation
import Observation


@Observable
final class Client {
    static let shared = Client()
    private let store = SettingsStore.shared
    
    func getBaseUrl() throws -> URL {
        var components = URLComponents()
        components.host = store.hostname
            .replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        if components.scheme == nil {
            components.scheme = store.hostname.contains("s://") ? "https" : "http"
        }
        guard let url = components.url else {
            throw ConnectionError.invalidHostname
        }
        return url
    }
    
    func sendRequest<REQ: Encodable, RES: Decodable>(
        endpoint: String,
        method: HttpMethod,
        body: REQ? = nil,
        headers: [String: String] = [:],
        query: [String: String] = [:],
    ) async throws -> ApiResponse<RES>? {
        if store.demoMode {
            return DemoClient.request()
        }
        do {
            var url = try! getBaseUrl()
            url.append(path: endpoint)
            let queryItems = query.map(URLQueryItem.init)
            url.append(queryItems: queryItems)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            if body != nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            if !store.apiKey.isEmpty {
                urlRequest.setValue(store.apiKey, forHTTPHeaderField: "x-api-key")
            }
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            if let body {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            }
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
//            if let rawString = String(data: data, encoding: .utf8) {
//                print("Raw Data as String:")
//                print(rawString)
//            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(ApiResponse<RES>.self, from: data)
            return decoded
            
        } catch {
            print("Unhandled Error")
            print(error)
            throw ConnectionError.requestFailed(response: error.localizedDescription)
        }
    }
    
    func sendRequest<RES: Decodable>(
        endpoint: String,
        method: HttpMethod,
        headers: [String: String] = [:],
        query: [String: String] = [:],
    ) async throws -> ApiResponse<RES>? {
        try await sendRequest(
            endpoint: endpoint,
            method: method,
            body: Optional<Data>.none as Data?,
            headers: headers,
            query: query
        ) as ApiResponse<RES>?
    }
}
