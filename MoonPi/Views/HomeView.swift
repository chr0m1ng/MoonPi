//
//  HomeView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import SwiftUI

struct HomeView: View {
    @State private var model = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
