//
//  VideoListView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 1/11/25.
//

import SwiftUI

struct VideoListView: View {
    @State private var model: VideoListViewModel
    let title: String
    
    init(_ title: String, _ fetcher: @escaping (Int8?, Int8?) async -> ApiResponse<VideoListResponse>?) {
        self.title = title
        self._model = State(initialValue: VideoListViewModel(fetcher: fetcher))
    }
    
    var body: some View {
        List(Array(model.videos.enumerated()), id: \.element.meta.id) { index, video in
            HStack {
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
                        Text(video.duration.timeString)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .onAppear() {
                    Task { await model.loadMoreIfNeeded(index: index) }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                Task { await model.play(video) }
            }
        }
        .contentMargins(.bottom, 88, for: .scrollContent)
        .refreshable(action: model.refresh)
        .navigationTitle(title)
        .scrollContentBackground(.hidden)
        if model.isLoading {
            ProgressView()
        }
    }
}

#Preview {
    VideoListView("History", HistoryApi.shared.list)
}
