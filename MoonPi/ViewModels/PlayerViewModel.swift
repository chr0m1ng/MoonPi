//
//  PlayerViewModel.swift
//  MoonPi
//
//  Created by Gabriel Santos on 2/11/25.
//

import Foundation
import Observation

struct PlayingVideo {
    var title: String = ""
    var duration: Double = 0
    var timePos: Double = 0
    var thumbnail: String = ""
    var volume: Double = 0
    var channel: String = ""
}

@Observable
@MainActor
final class PlayerViewModel {
    static var shared = PlayerViewModel()
    
    private let controlApi = ControlApi.shared
    private let statusApi = StatusApi.shared
    var video = PlayingVideo()
    var status: StatusResponse = StatusResponse.empty
    var processing: Bool = false
    var isIdle: Bool = true
    var blockUpdate: Bool = false
    
    @ObservationIgnored private var refreshTask: Task<Void, Never>?
    
    deinit { refreshTask?.cancel() }
    
    func startRefreshing(every interval: TimeInterval = 1) {
        guard refreshTask == nil else { return }  // idempotent
        refreshTask = Task { [weak self] in
            guard let self else { return }
            while !Task.isCancelled {
                if !self.blockUpdate {
                    self.syncData(with: await self.statusApi.get()?.data)
                }
                try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
            }
        }
    }
    
    func stopRefreshing() {
        refreshTask?.cancel()
        refreshTask = nil
    }
    
    var playingIcon: String {
        status.playing ? "pause.fill" : "play.fill"
    }
    
    func syncData(with: StatusResponse?) {
        status = with ?? status
        video.title = status.mediaTitle
        video.duration = status.duration
        video.timePos = status.timePos
        video.volume = Double(status.volume)
        video.channel = status.meta?.channel ?? video.channel
        video.thumbnail = status.meta?.thumbnail ?? video.thumbnail
        isIdle = status.idleActive
    }
    
    func pause() async {
        processing = true
        syncData(with: await controlApi.pause()?.data)
        processing = false
    }
    
    func resume() async {
        processing = true
        syncData(with: await controlApi.resume()?.data)
        processing = false
    }
    
    func stop() async {
        processing = true
        syncData(with: await controlApi.stop()?.data)
        processing = false
    }
    
    func togglePauseResume() async {
        processing = true
        var res: StatusResponse?
        if status.playing {
            res = await controlApi.pause()?.data
        } else {
            res = await controlApi.resume()?.data
        }
        syncData(with: res)
        processing = false
    }
    
    func changeVolume() async {
        processing = true
        syncData(with: await controlApi.volume(value: Int8(video.volume))?.data)
        processing = false
    }
}
