//
//  MoonPiApp.swift
//  MoonPi
//
//  Created by Gabriel Santos on 27/10/25.
//

import SwiftUI
import SwiftData

@main
struct MoonPiApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var loadingManager = LoadingManager.shared
    @State private var statusManager = StatusManager()
    @State private var videoManager = VideoManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema()
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(loadingManager)
                .environment(statusManager)
                .environment(videoManager)
                .onChange(of: scenePhase) { _, phase in
                    switch phase {
                    case .active: statusManager.start()
                    default: statusManager.stop()
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
