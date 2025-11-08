//
//  ThumbnailView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 5/11/25.
//

import SwiftUI

struct ThumbnailView: View {
    var thumbnail: String?
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat = 25
    
    var body: some View {
        ZStack {
            if let url = thumbnail, let imageURL = URL(string: url) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(.rect(cornerRadius: cornerRadius))
                    case .failure:
                        Image(systemName: "music.note")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.secondary)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                ProgressView()
            }
        }
        .frame(width: width, height: height)
        .shadow(radius: 25)
    }
}

#Preview {
    ThumbnailView(
        thumbnail: "https://img.youtube.com/vi/YzdvUS1ZxOc/mqdefault.jpg",
        width: 300,
        height: 200
    )
}
