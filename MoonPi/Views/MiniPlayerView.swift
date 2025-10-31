//
//  MiniPlayerView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import SwiftUI

struct MiniPlayerView: View {
    @Binding var title: String
    @Binding var channel: String
    @Binding var isPlaying: Bool
    @Binding var thumbnail: String
    
    var body: some View {
        NavigationStack {
            HStack {
                AsyncImage(url: URL(string: thumbnail)) { res in
                    res.image?
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 80, height: 70)
                .padding(.horizontal, 5)
                .clipShape(.rect(corners: .concentric()))
                VStack (alignment: .leading) {
                    Text(title)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Text(channel)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .imageScale(.large)
                    .padding(.trailing, 10)
            }
            .containerBackground(.clear, for: .navigation)
        }
        .frame(width: .infinity, height: 50)
        .padding()
        .glassEffect(in: .rect(cornerRadius: 16))
    }
}

#Preview {
    @Previewable @State var title: String = "Interpol - All The Rage Back Home"
    @Previewable @State var channel: String = "Interpol"
    @Previewable @State var isPlaying: Bool = true
    @Previewable @State var thumbnail: String = "https://img.youtube.com/vi/-u6DvRyyKGU/mqdefault.jpg"
    return MiniPlayerView(title: $title, channel: $channel, isPlaying: $isPlaying, thumbnail: $thumbnail)
}
