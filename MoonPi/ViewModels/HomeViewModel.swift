//
//  HomeViewModel.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import Foundation
import Observation

@Observable
@MainActor
final class HomeViewModel {
    private let loadingManager = LoadingManager.shared
    private let historyApi = HistoryApi.shared
    private let favoriteApi = FavoriteApi.shared
    private let healthApi = HealthApi.shared
    private let settingsStore = SettingsStore.shared
    var history: [VideoItem] = []
    var favorites: [VideoItem] = []
    var isConnected: Bool = false
    
    private func fetchHistory() async {
        let res = await historyApi.list(4)
        if res?.ok != true || res?.data?.items.isEmpty == true {
            return
        }
        history = res!.data!.items
    }
    
    private func fetchFavorites() async {
        let res = await favoriteApi.list(4)
        if res?.ok != true || res?.data?.items.isEmpty == true {
            return
        }
        favorites = res!.data!.items
    }
    
    func checkConnection() async {
        if settingsStore.demoMode {
            isConnected = true
            return
        }
        isConnected = await healthApi.get()?.ok ?? false
    }
    
    func refreshData() async {
        await loadingManager.withLoading {
            await checkConnection()
            await fetchHistory()
            await fetchFavorites()
        }
    }
}
