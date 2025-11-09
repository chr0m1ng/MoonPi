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
    private let loadingManager = LoadingManager.shared
    private var nextPage: Int8 = 0
    private var hasMore: Bool = false
    var videos: [VideoItem] = []
    let fetcher: (Int8?, Int8?) async -> ApiResponse<VideoListResponse>?
    
    
    init(fetcher: @escaping (Int8?, Int8?) async -> ApiResponse<VideoListResponse>?) {
        self.fetcher = fetcher
    }
    
    
    func loadMoreIfNeeded(index: Int) async {
        if !hasMore {
            return
        }
        if index == videos.count - 1 {
            await fetchVideos(append: true)
        }
    }
    
    func fetchVideos(append: Bool = false, skipLoading: Bool = false) async {
        await loadingManager.withLoading(skip: skipLoading) {
            if !append {
                nextPage = 0
            }
            let res = await fetcher(10, nextPage)
            if res?.ok != true || res?.data?.items.isEmpty == true {
                return
            }
            hasMore = res!.data!.hasNext
            nextPage += 1
            if append {
                videos.append(contentsOf: res!.data!.items)
            } else {
                videos = res!.data!.items
            }
        }
    }
    
    func refresh(_ skipLoading: Bool = false) async {
        await fetchVideos(skipLoading: skipLoading)
    }
}
