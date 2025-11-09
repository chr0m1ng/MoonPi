//
//  MainTabView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 28/10/25.
//

import SwiftUI

enum AppTab: Hashable {
    case home, favorites, search, settings
}

struct MainTabView: View {
    @Environment(StatusManager.self) private var statusManager
    @Environment(LoadingManager.self) private var loadingManager
    @State private var selectedTab: AppTab = .home
    @State private var isFullPlayerPresent = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                NavigationStack {
                    HomeView()
                        .navigationTitle("Home")
                }
            }
            Tab("Settings", systemImage: "gearshape.fill", value: .settings) {
                NavigationStack {
                    SettingsView()
                        .navigationTitle("Settings")
                }
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
                NavigationStack {
                    SearchView()
                        .navigationTitle("Search")
                }
            }
        }
        .sheet(isPresented: $isFullPlayerPresent) {
            FullPlayerView(statusManager)
                .presentationDetents([.large])
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if !statusManager.status.idleActive {
                MiniPlayerView(statusManager)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 85)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .onTapGesture {
                        isFullPlayerPresent = true
                    }
            }
        }
    }
}

#Preview {
    MainTabView()
        .withAppEnvs()
}
