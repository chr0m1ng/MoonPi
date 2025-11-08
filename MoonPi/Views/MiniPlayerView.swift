//
//  MiniPlayerView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import SwiftUI

struct MiniPlayerView: View {
    @Environment(VideoManager.self) private var videoManager
    @State private var model: PlayerViewModel
    
    init(_ statusManager: StatusManager) {
        _model = State(initialValue: PlayerViewModel(statusManager))
    }
    
    var body: some View {
        HStack (alignment: .center) {
            ThumbnailView(
                thumbnail: model.status.meta?.thumbnail,
                width: 80, height: 60, cornerRadius: 16
            )
            VStack (alignment: .leading) {
                Text(model.status.mediaTitle)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(model.status.meta?.channel ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
            Button {
                Task { await videoManager.stop() }
            } label: {
                Image(systemName: "stop.fill")
                    .imageScale(.medium)
            }
            .buttonStyle(.plain)
            Button {
                Task { await videoManager.pauseOrResume(isPlaying: model.isPlaying) }
            } label: {
                Image(systemName: model.playingIcon)
                    .imageScale(.large)
                    .padding(.horizontal, 5)
            }
            .buttonStyle(.plain)
        }
        .contentShape(Rectangle())
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .glassEffect()
    }
}

#Preview {
    MiniPlayerView(StatusManager())
}
