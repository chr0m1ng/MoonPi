//
//  GalleryView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 1/11/25.
//

import SwiftUI

struct GalleryView<Destination: View>: View {
    @Environment(LoadingManager.self) private var loading
    private let controlApi = ControlApi.shared
    let title: String
    let destination: Destination
    let videos: [VideoItem]
    
    var body: some View {
        VStack (alignment: .leading) {
            NavigationLink(destination: destination) {
                HStack {
                    Text(title)
                        .font(.title2)
                        .bold()
                    Image(systemName: "greaterthan")
                        .foregroundStyle(.gray)
                }
            }
            .buttonStyle(.plain)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                ForEach(videos.indices, id: \.self) { index in
                    let video = videos[index]
                    VStack (alignment: .leading) {
                        ThumbnailView(
                            thumbnail: video.meta.thumbnail, width: 170, height: 120
                        )
                        Section {
                            Text(video.title)
                                .font(.headline)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundStyle(.primary)
                            Text(video.meta.channel)
                                .font(.subheadline)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        Task {
                            await loading.withLoading {
                                _ = await controlApi.play(url: video.url)
                            }
                        }
                    }
                }
            }
        }
    }
}
