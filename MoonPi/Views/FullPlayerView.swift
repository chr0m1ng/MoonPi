//
//  FullPlayerView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 2/11/25.
//

import SwiftUI

struct FullPlayerView: View {
    @Environment(LoadingManager.self) private var loadingManager
    @Environment(VideoManager.self) private var videoManager
    @State private var model: PlayerViewModel
    
    init(_ statusManager: StatusManager) {
        _model = State(initialValue: PlayerViewModel(statusManager))
    }
    
    var body: some View {
        if model.status.mediaTitle.isEmpty {
            ProgressView()
        } else {
            VStack (alignment: .center, spacing: 40) {
                ThumbnailView(
                    thumbnail: model.status.meta?.thumbnail,
                    width: 350, height: 200
                )
                Section {
                    VStack (alignment: .center, spacing: 10) {
                        Text(model.status.mediaTitle)
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.primary)
                        Text(model.status.meta?.channel ?? "")
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.secondary)
                    }
                }
                Section {
                    VStack {
                        if model.status.duration != nil {
                            Slider(value: $model.timePos, in: 0.0...model.status.duration!)
                                .disabled(true)
                                .sliderThumbVisibility(.hidden)
                                .tint(.gray)
                        }
                        HStack {
                            Text(model.timePos.timeString)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(model.status.duration?.timeString ?? "LIVE")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Section {
                    HStack (spacing: 50) {
                        Button {
                            Task { await videoManager.stop() }
                        } label: {
                            Image(systemName: "stop.fill")
                                .imageScale(.large)
                                .font(.title3)
                        }
                        .buttonStyle(.plain)
                        Button {
                            Task { await videoManager.pauseOrResume(isPlaying: model.isPlaying) }
                        } label: {
                            Image(systemName: model.playingIcon)
                                .imageScale(.large)
                                .font(.largeTitle)
                        }
                        .buttonStyle(.plain)
                        Button {
                            Task { await model.saveToFavorites() }
                        } label: {
                            Image(systemName: "star.fill")
                                .imageScale(.large)
                                .font(.title3)
                        }
                        .buttonStyle(.plain)
                    }
                }
                Section {
                    HStack (spacing: 10) {
                        Image(systemName: "speaker.fill")
                        Slider(value: $model.volume, in: 0.0...100, step: 1) { editing in
                            if !editing {
                                Task { await videoManager.volume(at: model.volume) }
                            }
                        }
                        .tint(.gray)
                        Image(systemName: "speaker.wave.3.fill")
                    }
                }
            }
            .padding(20)
            .loadingOverlay(loadingManager.isLoading)
            .zIndex(2)
            .ignoresSafeArea(.keyboard, edges: .all)
        }
    }
}

#Preview {
    FullPlayerView(StatusManager())
}
