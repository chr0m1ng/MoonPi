//
//  PlayerViewModel.swift
//  MoonPi
//
//  Created by Gabriel Santos on 2/11/25.
//

import Foundation
import Observation

@Observable
@MainActor
final class PlayerViewModel {
    private let statusManager: StatusManager
    private let loadingManager = LoadingManager.shared
    
    private let controlApi = ControlApi.shared
    private let favoriteApi = FavoriteApi.shared
    var timePos: Double = 0
    var volume: Double = 0
    var blockUpdate: Bool = false
    var isFavorite: Bool = false
    
    init(_ statusManager: StatusManager) {
        self.statusManager = statusManager
    }
    
    var status: StatusResponse {
        timePos = statusManager.status.timePos
        volume = Double(statusManager.status.volume)
        return statusManager.status
    }
    
    var isPlaying: Bool {
        status.playing
    }
    
    var playingIcon: String {
        isPlaying ? "pause.fill" : "play.fill"
    }
    
    var favoriteIcon: String {
        isFavorite ? "star.fill" : "star"
    }
    
    func checkIsFavorite() async {
        guard let url = status.meta?.url else { return }
        await loadingManager.withLoading {
            isFavorite = await favoriteApi.isFavorite(url: url)
        }
    }
    
    func toggleFavorite() async {
        guard let url = status.meta?.url else { return }
        await loadingManager.withLoading {
            if isFavorite {
                _ = await favoriteApi.remove(url: url)
            } else {
                _ = await favoriteApi.add(url: url)
            }
            await checkIsFavorite()
        }
    }
}
