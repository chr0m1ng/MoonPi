//
//  HomeView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import SwiftUI

struct HomeView: View {
    @State private var model = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if !model.isConnected {
                    Text("Cannot reach server, you can enable demo mode in settings")
                        .padding()
                } else {
                    GalleryView(title: "Recently Played", destination: VideoListView("History", HistoryApi.shared.list), videos: model.history)
                    GalleryView(title: "Favorites", destination: VideoListView("Favorites", FavoriteApi.shared.list), videos: model.favorites)
                        .padding(.top, 20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
            .navigationTitle("Home")
        }
        .contentMargins(.bottom, 88, for: .scrollContent)
        .refreshable(action: model.refreshData)
        .task {
            await model.refreshData()
        }
    }
}

#Preview {
    HomeView()
}
