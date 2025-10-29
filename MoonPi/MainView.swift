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
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                Text("Home")
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
    }
}

#Preview {
    MainView()
}
