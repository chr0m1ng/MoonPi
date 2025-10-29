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
    var testErrorDescription: String? = nil
    var isTestSuccessful: Bool? = nil
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
    var testConnectionIcon: String {
        if testErrorDescription != nil || isTestSuccessful == false {
            return "network.slash"
        }
        if isTestSuccessful == true {
            return "checkmark.circle"
        }
        return "network"
    }
    
    func testConnection() async {
        isTestingConnection = true
        testErrorDescription = nil
        isTestSuccessful = nil
        
        guard var components = URLComponents(string: hostname) else {
            testErrorDescription = "Invalid hostname"
            isTestingConnection = false
            isTestSuccessful = false
            return
        }
        
        if components.scheme == nil {
            components.scheme = "http"
        }
        components.path.append("/health")
        
        guard let url = components.url else {
            testErrorDescription = "Invalid URL"
            isTestingConnection = false
            isTestSuccessful = false
            return
        }
        
        do {
            var req = URLRequest(url: url, timeoutInterval: 6)
            if !apiKey.isEmpty {
                req.addValue(apiKey, forHTTPHeaderField: "x-api-key")
            }
            
            let (data, response) = try await URLSession.shared.data(for: req)
            if let http = response as? HTTPURLResponse, http.statusCode == 200 {
                isTestSuccessful = true
            } else {
                let body = String(data: data, encoding: .utf8) ?? "Unexpected response"
                testErrorDescription = body
                isTestSuccessful = false
            }
        } catch {
            testErrorDescription = error.localizedDescription
            isTestSuccessful = false
        }
        isTestingConnection = false
    }
}
