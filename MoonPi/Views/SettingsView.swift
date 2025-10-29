//
//  SettingsView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 28/10/25.
//


import SwiftUI

struct SettingsView: View {
    @State private var model = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink(destination: InputView(name: "Host", value: $model.hostname, autocorrectionDisabled: true)) {
                        HStack {
                            Text("Host")
                            Spacer()
                            Text(model.hostname)
                                .foregroundStyle(.secondary)
                        }
                    }
                    NavigationLink(destination: InputView(name: "API Key", value: $model.apiKey, autocorrectionDisabled: true)) {
                        HStack {
                            Text("API Key")
                            Spacer()
                            Text(model.apiKey.isEmpty ? "(optional)" : model.apiKey)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Section {
                    Button {
                        Task { await model.testConnection() }
                    } label: {
                        if model.isTestingConnection {
                            HStack(spacing: 8) {
                                ProgressView()
                                    .controlSize(.small)
                                Text("Testing...")
                            }
                        } else {
                            Label("Test Connection", systemImage: model.testConnectionIcon)
                        }
                    }
                    .disabled(model.isTestDisabled)
                } footer: {
                    if let status = model.testErrorDescription {
                        Text(status)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}


#Preview {
    SettingsView()
}
