//
//  SearchView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 5/11/25.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State private var model = SearchViewModel()
    @State private var debounceTask: Task<Void, Never>?
    
    var body: some View {
        Group {
            if !model.isSearching {
                List {
                    ForEach(model.history.indices, id: \.self) { index in
                        let item = model.history[index]
                        HStack {
                            Text(item)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            model.searchText = item
                        }
                    }
                    .onDelete { offSets in
                        Task {
                            await model.removeEntries(at: offSets)
                        }
                    }
                }
                .contentMargins(.bottom, 90, for: .scrollContent)
                .task {
                    await model.fetchHistory()
                }
            } else {
                VideoListView("Search", model.search)
            }
        }
        .searchable(text: $model.searchText)
        .onChange(of: model.searchText) { _, newValue in
            debounceTask?.cancel()
            if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                model.isSearching = false
                return
            }
            debounceTask = Task {
                try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
                guard !Task.isCancelled else { return }
                await MainActor.run { model.isSearching = true }
            }
        }
    }
}

#Preview {
    SearchView()
}
