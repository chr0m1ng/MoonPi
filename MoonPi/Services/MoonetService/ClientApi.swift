//
//  Client.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import Foundation
import Observation

enum ConnectionError: Error {
    case invalidHostname
    case requestFailed(response: String)
}

@Observable
final class Client {
    static let shared = Client()
    private let store = SettingsStore.shared
    
    func getBaseUrl() throws -> URL {
        var components = URLComponents()
        components.host = store.hostname.replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "http://", with: "")
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
        headers: [String: String] = [:]
    ) async throws -> ApiResponse<RES>? {
        do {
            var url = try! getBaseUrl()
            url.append(path: endpoint)
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
            print(urlRequest)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            if let rawString = String(data: data, encoding: .utf8) {
                print("Raw Data as String:")
                print(rawString)
            } else {
                print("Could not convert data to UTF-8 string.")
                // You can also print the raw Data object if string conversion fails
                print("Raw Data (binary representation):")
                print(data)
            }
            let decoded = try JSONDecoder().decode(ApiResponse<RES>.self, from: data)
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
        headers: [String: String] = [:]
    ) async throws -> ApiResponse<RES>? {
        try await sendRequest(
            endpoint: endpoint,
            method: method,
            body: Optional<Data>.none as Data?, // type erased to keep body nil without constraining REQ
            headers: headers
        ) as ApiResponse<RES>?
    }
}
