//
//  VideoListViewModel.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import Foundation
import Observation


@Observable
@MainActor
final class VideoListViewModel {
    private let controlApi = ControlApi.shared
    private var nextPage: Int8 = 0
    private var hasMore: Bool = false
    var isLoading: Bool = false
    var videos: [VideoItem] = []
    let fetcher: (Int8?, Int8?) async -> ApiResponse<VideoListResponse>?
    
    
    init(fetcher: @escaping (Int8?, Int8?) async -> ApiResponse<VideoListResponse>?) {
        self.fetcher = fetcher
        Task { await fetchVideos() }
    }
    
    func play(_ video: VideoItem) async {
        _ = await controlApi.play(url: video.url)
    }
    
    func loadMoreIfNeeded(index: Int) async {
        if !hasMore {
            return
        }
        if index == videos.count - 1 {
            await fetchVideos(append: true)
        }
    }
    
    func fetchVideos(append: Bool = false) async {
        isLoading = true
        if !append {
            nextPage = 0
        }
        let res = await fetcher(7, nextPage)
        if res?.ok != true || res?.data?.items.isEmpty == true {
            isLoading = false
            return
        }
        hasMore = res!.data!.hasNext
        nextPage += 1
        if append {
            videos.append(contentsOf: res!.data!.items)
        } else {
            videos = res!.data!.items
        }
        isLoading = false
    }
    
    func refresh() async {
        await fetchVideos()
    }
}
