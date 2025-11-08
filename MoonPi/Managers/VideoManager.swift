//
//  VideoManager.swift
//  MoonPi
//
//  Created by Gabriel Santos on 8/11/25.
//


import Observation

@Observable
@MainActor
final class VideoManager {
    private let loading = LoadingManager.shared
    private let controlApi = ControlApi.shared
    
    func play(_ url: String) async {
        await loading.withLoading {
            _ = await controlApi.play(url: url)
        }
    }
    
    func pauseOrResume(isPlaying: Bool) async {
        await loading.withLoading {
            if isPlaying {
                _ = await controlApi.pause()
            } else {
                _ = await controlApi.resume()
            }
        }
    }
    
    func stop() async {
        await loading.withLoading {
            _ = await controlApi.stop()
        }
    }
    
    func volume(at value: Double) async {
        await loading.withLoading {
            _ = await controlApi.volume(value: Int8(value))
        }
    }
}
