//
//  AppView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 8/11/25.
//

import SwiftUI

struct AppView: View {
    @Environment(LoadingManager.self) private var loadingManager
    
    var body: some View {
        MainTabView()
            .loadingOverlay(loadingManager.isLoading)
    }
}

#Preview {
    AppView()
        .withAppEnvs()
}
