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
        static let demoMode = "demoMode"
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
    
    var demoMode: Bool {
        didSet {
            UserDefaults.standard.set(demoMode, forKey: Keys.demoMode)
        }
    }
    
    init() {
        hostname = UserDefaults.standard.string(forKey: Keys.hostname) ?? "moonet.local"
        apiKey = UserDefaults.standard.string(forKey: Keys.apiKey) ?? ""
        demoMode = UserDefaults.standard.bool(forKey: Keys.demoMode)
    }
}
