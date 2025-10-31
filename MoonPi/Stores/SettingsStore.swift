//
//  SettingsStore.swift
//  MoonPi
//
//  Created by Gabriel Santos on 28/10/25.
//

import SwiftUI
import Observation

@Observable
final class SettingsStore {
    static let shared = SettingsStore()

    private enum Keys {
        static let hostname = "hostname"
        static let apiKey = "apiKey"
    }
    
    var hostname: String {
        didSet {
            UserDefaults.standard.set(hostname, forKey: Keys.hostname)
        }
    }
    
    var apiKey: String {
        didSet {
            UserDefaults.standard.set(apiKey, forKey: Keys.apiKey)
        }
    }
    
    init() {
        hostname = UserDefaults.standard.string(forKey: Keys.hostname) ?? "moonet.local"
        apiKey = UserDefaults.standard.string(forKey: Keys.apiKey) ?? ""
    }
}
