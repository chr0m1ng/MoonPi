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
    private let historyApi = HistoryApi.shared
    private let favoriteApi = FavoriteApi.shared
    var history: [VideoItem] = []
    var favorites: [VideoItem] = []
    
    func fetchHistory() async {
        let res = await historyApi.list(4)
        if res?.ok != true || res?.data?.items.isEmpty == true {
            return
        }
        history = res!.data!.items
    }
    
    func fetchFavorites() async {
        let res = await favoriteApi.list(4)
        if res?.ok != true || res?.data?.items.isEmpty == true {
            return
        }
        favorites = res!.data!.items
    }
    
    func refreshData() async {
        async let h: Void = fetchHistory()
        async let f: Void = fetchFavorites()
        _ = await (h, f)
    }
}
