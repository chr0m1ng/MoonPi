//
//  SettingsViewModel.swift
//  MoonPi
//
//  Created by Gabriel Santos on 28/10/25.
//

import Foundation
import Observation

@Observable
@MainActor
final class SettingsViewModel {
    private let store = SettingsStore.shared
    
    var isTestingConnection = false
    var connectionStatus: String? = nil
    var hostname: String {
        get { store.hostname }
        set { store.hostname = newValue }
    }
    var apiKey: String {
        get { store.apiKey }
        set { store.apiKey = newValue }
    }
    var isTestDisabled: Bool {
        hostname.isEmpty || isTestingConnection
    }
    
    func testConnection() async {
        isTestingConnection = true
        connectionStatus = nil
        
        guard var components = URLComponents(string: hostname) else {
            connectionStatus = "Invalid hostname"
            isTestingConnection = false
            return
        }
        
        if components.scheme == nil {
            components.scheme = "http"
        }
        components.path.append("/health")
        
        guard let url = components.url else {
            connectionStatus = "Invalid URL"
            isTestingConnection = false
            return
        }
        
        do {
            var req = URLRequest(url: url, timeoutInterval: 6)
            if !apiKey.isEmpty {
                req.addValue(apiKey, forHTTPHeaderField: "x-api-key")
            }
            
            let (data, response) = try await URLSession.shared.data(for: req)
            if let http = response as? HTTPURLResponse, http.statusCode == 200 {
                connectionStatus = "✅ Connected"
            } else {
                let body = String(data: data, encoding: .utf8) ?? "Unexpected response"
                connectionStatus = "⚠️ \(body)"
            }
        } catch {
            connectionStatus = "❌ \(error.localizedDescription)"
        }
        isTestingConnection = false
    }
}
