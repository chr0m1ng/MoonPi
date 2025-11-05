//
//  GalleryView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 1/11/25.
//

import SwiftUI

struct GalleryView<Destination: View>: View {
    @State private var model = GalleryViewModel()
    let title: String
    let destination: Destination
    let videos: [VideoItem]
    
    var body: some View {
        VStack (alignment: .leading) {
            NavigationLink(destination: destination) {
                HStack {
                    Text(title)
                        .font(.title2)
                        .bold()
                    Image(systemName: "greaterthan")
                        .foregroundStyle(.gray)
                }
            }
            .buttonStyle(.plain)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                ForEach(videos, id: \.meta.id) { video in
                    VStack (alignment: .leading) {
                        AsyncImage(url: URL(string: video.meta.thumbnail)) { res in
                            res.image?
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 25))
                        }
                        .frame(minWidth: 120, minHeight: 120, maxHeight: 150, alignment: .center)
                        Text(video.title)
                            .font(.headline)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundStyle(.primary)
                        Text(video.meta.channel)
                            .font(.subheadline)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundStyle(.secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        Task { await model.play(video) }
                    }
                }
            }
        }
    }
}
