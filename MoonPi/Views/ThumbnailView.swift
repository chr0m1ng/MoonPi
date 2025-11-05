//
//  ThumbnailView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 5/11/25.
//

import SwiftUI

struct ThumbnailView: View {
    @State var thumbnail: String
    @State var width: CGFloat
    @State var height: CGFloat
    @State var cornerRadius: CGFloat = 25
    
    var body: some View {
        AsyncImage(url: URL(string: thumbnail)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .backgroundStyle(.clear)
                    .clipShape(.rect(cornerRadius: cornerRadius))
            } else if phase.error != nil {
                Image(systemName: "music.note")
                    .resizable()
                    .scaledToFit()
                    .backgroundStyle(.clear)
            } else {
                ProgressView()
            }
        }
        .frame(width: width, height: height, alignment: .center)
        .shadow(radius: 25)
    }
}

#Preview {
    ThumbnailView(
        thumbnail: "https://img.youtube.com/vi/YzdvUS1ZxOc/mqdefault.jpg", width: 300, height: 200
    )
}
