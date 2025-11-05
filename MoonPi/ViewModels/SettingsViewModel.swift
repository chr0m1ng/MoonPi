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
    private let healthApi = HealthApi.shared
    
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
        let res = await healthApi.get()
        if res?.ok == true {
            isTestSuccessful = true
        } else {
            testErrorDescription = res?.error ?? "Unexpected response"
            isTestSuccessful = false
        }
        isTestingConnection = false
    }
}
