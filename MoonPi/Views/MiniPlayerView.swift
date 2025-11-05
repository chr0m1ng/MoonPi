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
        NavigationStack {
            HStack {
                AsyncImage(url: URL(string: model.video.thumbnail)) { res in
                    (res.image ?? Image(systemName: "music.note"))
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 16))
                .padding(5)
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
            .containerBackground(.clear, for: .navigation)
        }
        .frame(width: .infinity, height: 50)
        .padding(10)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .opacity(model.isIdle ? 0 : 1)
    }
}

#Preview {
    return MiniPlayerView()
}
