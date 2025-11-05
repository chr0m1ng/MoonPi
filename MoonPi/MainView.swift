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
    @State private var isFullPlayerPresent = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                NavigationStack {
                    HomeView()
                        .navigationTitle("Home")
                }
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    if !player.isIdle {
                        MiniPlayerView()
                            .padding(.horizontal, 20)
                            .padding(.bottom, 8)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .onTapGesture {
                                isFullPlayerPresent = true
                            }
                    }
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
                    Text("Search")
                        .navigationTitle("Search")
                }
            }
        }
        .sheet(isPresented: $isFullPlayerPresent) {
            FullPlayerView()
                .presentationDetents([.large])
        }
        .task { player.startRefreshing() }
        .onDisappear { player.stopRefreshing() }
    }
}

#Preview {
    MainView()
}
