//
//  FullPlayerView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 2/11/25.
//

import SwiftUI

struct FullPlayerView: View {
    @State private var model = PlayerViewModel.shared
    
    var body: some View {
        if model.video.title == "" {
            ProgressView()
        } else {
            VStack (alignment: .center, spacing: 40) {
                ThumbnailView(
                    thumbnail: model.video.thumbnail,
                    width: 350, height: 200
                )
                Section {
                    VStack (alignment: .center, spacing: 10) {
                        Text(model.video.title)
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.primary)
                        Text(model.video.channel)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.secondary)
                    }
                }
                Section {
                    VStack {
                        Slider(value: $model.video.timePos, in: 0.0...model.video.duration)
                            .disabled(true)
                            .sliderThumbVisibility(.hidden)
                            .tint(.gray)
                        HStack {
                            Text(model.video.timePos.timeString)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(model.video.duration.timeString)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Section {
                    HStack (spacing: 50) {
                        Button {
                            Task { await model.stop() }
                        } label: {
                            Image(systemName: "stop.fill")
                                .imageScale(.large)
                                .font(.title3)
                        }
                        .disabled(model.processing)
                        .buttonStyle(.plain)
                        Button {
                            Task { await model.togglePauseResume() }
                        } label: {
                            Image(systemName: model.playingIcon)
                                .imageScale(.large)
                                .font(.largeTitle)
                        }
                        .disabled(model.processing)
                        .buttonStyle(.plain)
                        Button(" ") {}
                            .hidden()
                            .buttonStyle(.glass)
                    }
                }
                Section {
                    HStack (spacing: 10) {
                        Image(systemName: "speaker.fill")
                        Slider(value: $model.video.volume, in: 0.0...100, step: 1) { editing in
                            if editing {
                                model.blockUpdate = true
                                model.processing = true
                            }
                            if !editing {
                                Task { await model.changeVolume() }
                                model.blockUpdate = false
                            }
                        }
                        .tint(.gray)
                        Image(systemName: "speaker.wave.3.fill")
                    }
                }
            }
            .padding(20)
        }
    }
}

#Preview {
    FullPlayerView()
}
