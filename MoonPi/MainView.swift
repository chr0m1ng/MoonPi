//
//  MainView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 28/10/25.
//

import SwiftUI

enum AppTab: Hashable {
    case home, favorites, search, settings
}

struct MainView: View {
    @State private var selectedTab: AppTab = .home
    @State private var player = PlayerViewModel.shared

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                HomeView()
            }
            Tab("Settings", systemImage: "gearshape.fill", value: .settings) {
                SettingsView()
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
                Text("Search")
            }
        }
        .task { player.startRefreshing() }
        .onDisappear { player.stopRefreshing() }
        .overlay(alignment: .bottom) {
            MiniPlayerView()
                .padding(.bottom, 60)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MainView()
}
