//
//  StatusManager.swift
//  MoonPi
//
//  Created by Gabriel Santos on 8/11/25.
//


import Observation

@Observable
@MainActor
final class StatusManager {
    private let statusApi = StatusApi.shared
    @ObservationIgnored private var task: Task<Void,Never>?
    @ObservationIgnored private var inFlight = false
    @ObservationIgnored private var baseInterval = 1.0
    @ObservationIgnored private var backoff = 1.0
    @ObservationIgnored private let maxBackoff = 10.0
    
    
    var status: StatusResponse = StatusResponse.empty    
    
    func start(immediate: Bool = true) {
        stop()
        task = Task { [weak self] in
            guard let self else { return }
            if immediate { await tick() }
            while !Task.isCancelled {
                if !inFlight { await tick() }
                try? await Task.sleep(nanoseconds: UInt64((baseInterval * backoff) * 1_000_000_000))
            }
        }
    }
    
    
    func stop() { task?.cancel(); task = nil; inFlight = false }
    
    private func tick() async {
        inFlight = true
        defer { inFlight = false }
        if let res = await statusApi.get(), res.ok {
            status = res.data ?? status
            backoff = 1.0
        } else {
            bumpBackoff()
        }
    }
    
    private func bumpBackoff() {
        backoff = min(maxBackoff, backoff * 1.6)
        let jitter = 0.8 + Double.random(in: 0...0.4)
        backoff *= jitter
    }
}
