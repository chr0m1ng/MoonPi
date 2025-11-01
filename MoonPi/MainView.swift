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
    @State private var title: String = "Interpol - All The Rage Back Home"
    @State private var channel: String = "Interpol"
    @State private var isPlaying: Bool = true
    @State var thumbnail: String = "https://img.youtube.com/vi/-u6DvRyyKGU/mqdefault.jpg"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                HomeView()
            }
            Tab("Favorites", systemImage: "star.fill", value: .favorites) {
                Text("Favorites")
            }
            Tab("Settings", systemImage: "gearshape.fill", value: .settings) {
                SettingsView()
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
                Text("Search")
            }
        }
        .overlay(alignment: .bottom) {
            MiniPlayerView(title: $title, channel: $channel, isPlaying: $isPlaying, thumbnail: $thumbnail)
                .padding(.bottom, 60)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MainView()
}
