//
//  GalleryViewModel.swift
//  MoonPi
//
//  Created by Gabriel Santos on 29/10/25.
//

import Foundation
import Observation


@Observable
@MainActor
final class GalleryViewModel {
    private let controlApi = ControlApi.shared
    
    func play(_ video: VideoItem) async {
        _ = await controlApi.play(url: video.url)
    }
}
