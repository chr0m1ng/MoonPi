//
//  SearchViewModel.swift
//  MoonPi
//
//  Created by Gabriel Santos on 05/11/25.
//

import Foundation
import Observation


@Observable
@MainActor
final class SearchViewModel {
    private let loadingManager = LoadingManager.shared
    private let searchApi = SearchApi.shared
    var searchText: String = ""
    var history: [String] = []
    var isSearching: Bool = false
    
    func fetchHistory() async {
        await loadingManager.withLoading {
            history = await searchApi.listHistory()?.data ?? history
        }
    }
    
    func search(_ limit: Int8?, _ page: Int8?) async -> ApiResponse<VideoListResponse>? {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return nil
        }
        return await loadingManager.withLoading {
            await searchApi.search(query: searchText, limit, page)
        }
    }
    
    func removeEntries(at offSets: IndexSet) async {
        await loadingManager.withLoading {
            for offset in offSets {
                _ = await searchApi.deleteFromHistory(query: history[offset])
            }
            await fetchHistory()
        }
    }
}
