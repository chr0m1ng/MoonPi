//
//  VideoListView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 1/11/25.
//

import SwiftUI

struct VideoListView: View {
    @Environment(VideoManager.self) private var videoManager
    @State private var model: VideoListViewModel
    
    let title: String
    var skipLoading: Bool = false
    
    init(_ title: String, _ fetcher: @escaping (Int8?, Int8?) async -> ApiResponse<VideoListResponse>?, skipLoading: Bool = false) {
        self.title = title
        self._model = State(initialValue: VideoListViewModel(fetcher: fetcher))
        self.skipLoading = skipLoading
    }
    
    var body: some View {
        List(model.videos.indices, id: \.self) { index in
            let video = model.videos[index]
            HStack (alignment: .center, spacing: 20) {
                ThumbnailView(
                    thumbnail: video.meta.thumbnail, width: 100, height: 80
                )
                VStack (alignment: .leading) {
                    Text(video.title)
                        .font(.headline)
                        .truncationMode(.tail)
                        .foregroundStyle(.primary)
                    HStack {
                        Text(video.meta.channel)
                            .font(.subheadline)
                            .truncationMode(.tail)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(video.duration?.timeString ?? "LIVE")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .task {
                    await model.loadMoreIfNeeded(index: index)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                Task { await videoManager.play(video.url) }
            }
        }
        .task {
            Task { await model.refresh(skipLoading) }
        }
        .contentMargins(.bottom, 88, for: .scrollContent)
        .refreshable() {
            Task { await model.refresh() }
        }
        .navigationTitle(title)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    VideoListView("History", HistoryApi.shared.list)
}
