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
                AsyncImage(url: URL(string: video.meta.thumbnail)) { res in
                    if let img = res.image {
                        img
                            .resizable()
                            .scaledToFit()
                            .backgroundStyle(.clear)
                            .clipShape(.rect(cornerRadius: 25))
                    } else {
                        ProgressView()
                    }
                }
                .frame(minWidth: 80, minHeight: 80, maxHeight: 100, alignment: .center)
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
                .contentShape(Rectangle())
                .onAppear() {
                    Task { await model.loadMoreIfNeeded(index: index) }
                }
            }
            .onTapGesture {
                Task { await model.play(video) }
            }
            .listRowBackground(Color.clear)
        }
        .refreshable(action: model.refresh)
        .navigationTitle(title)
        .scrollContentBackground(.hidden)
        .padding(.bottom, 80)
        if model.isLoading {
            ProgressView()
                .padding(.bottom, 80)
        }
    }
}

#Preview {
    VideoListView("Favorites", HistoryApi.shared.list)
}
