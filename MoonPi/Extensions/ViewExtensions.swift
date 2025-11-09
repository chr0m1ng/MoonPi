//
//  ViewExtensions.swift
//  MoonPi
//
//  Created by Gabriel Santos on 5/11/25.
//

import SwiftUI

extension View {
    func loadingOverlay(_ isLoading: Bool) -> some View {
        ZStack {
            self
                .blur(radius: isLoading ? 3 : 0)
                .allowsHitTesting(!isLoading)
            
            if isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                ProgressView()
                    .padding(40)
                    .background(Color.clear)
                    .glassEffect(in: .rect(cornerRadius: 16))
            }
        }
        .ignoresSafeArea()
        .animation(.easeInOut, value: isLoading)
    }
    
    func withAppEnvs() -> some View {
        let status = StatusManager()
        let loading = LoadingManager.shared
        let video = VideoManager()
        return self
            .environment(status)
            .environment(loading)
            .environment(video)
            .onAppear {
                status.start()
            }
    }
}

#Preview {
    MainTabView().withAppEnvs()
}


#Preview {
    EmptyView()
        .loadingOverlay(true)
}
