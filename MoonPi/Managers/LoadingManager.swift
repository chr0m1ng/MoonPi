//
//  LoadingManager.swift
//  MoonPi
//
//  Created by Gabriel Santos on 6/11/25.
//

import Foundation

@MainActor
@Observable
final class LoadingManager {
    static let shared = LoadingManager()
    
    private var counter = 0
    var isLoading: Bool { counter > 0 }
    
    func show() { counter += 1 }
    func hide() { counter = max(0, counter - 1) }
    
    func withLoading<T>(skip: Bool = false, _ work: () async throws -> T) async rethrows -> T {
        if skip {
            return try await work()
        }
        show()
        defer { hide() }
        return try await work()
    }
}
