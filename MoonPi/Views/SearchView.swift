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
    @State private var committedQuery: String = ""
    
    var body: some View {
        Group {
            if committedQuery.isEmpty {
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
                VideoListView("Search", { limit, page in
                    await model.search(query: committedQuery, limit, page)
                }, skipLoading: true)
                .id(committedQuery)
            }
        }
        .searchable(text: $model.searchText)
        .onChange(of: model.searchText) { _, newValue in
            debounceTask?.cancel()
            let trimmed = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmed.isEmpty {
                committedQuery = ""
                return
            }
            debounceTask = Task {
                try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
                guard !Task.isCancelled else { return }
                await MainActor.run {
                    committedQuery = trimmed
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
