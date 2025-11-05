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
        NavigationStack {
            ScrollView {
                VStack {
                    GalleryView(title: "Recently Played", destination: VideoListView("History", HistoryApi.shared.list), videos: model.history)
                    GalleryView(title: "Favorites", destination: VideoListView("History", FavoriteApi.shared.list), videos: model.favorites)
                        .padding(.top, 10)
                        .padding(.bottom, 65)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(20)
                .navigationTitle("Home")
            }
            .refreshable(action: model.refreshData)
        }
        .onAppear {
            Task { await model.refreshData() }
        }
    }
}

#Preview {
    HomeView()
}
