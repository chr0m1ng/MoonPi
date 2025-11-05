//
//  MiniPlayerView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import SwiftUI

struct MiniPlayerView: View {
    @State private var model = PlayerViewModel.shared
    
    var body: some View {
        HStack (alignment: .center) {
            ThumbnailView(
                thumbnail: model.video.thumbnail,
                width: 80, height: 60, cornerRadius: 16
            )
            VStack (alignment: .leading) {
                Text(model.video.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(model.video.channel)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
            Button {
                Task { await model.stop() }
            } label: {
                Image(systemName: "stop.fill")
                    .imageScale(.medium)
            }
            .disabled(model.processing)
            .buttonStyle(.plain)
            Button {
                Task { await model.togglePauseResume() }
            } label: {
                Image(systemName: model.playingIcon)
                    .imageScale(.large)
                    .padding(.horizontal, 5)
            }
            .disabled(model.processing)
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .glassEffect()
    }
}

#Preview {
    return MiniPlayerView()
}
