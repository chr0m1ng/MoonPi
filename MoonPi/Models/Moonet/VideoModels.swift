//
//  VideoModels.swift
//  MoonPi
//
//  Created by Gabriel Santos on 5/11/25.
//

final class VideoItem: Decodable {
    let title: String
    let url: String
    let duration: Double?
    let meta: Meta
    let playedAt: Int64?
    
    internal class Meta: Decodable {
        let thumbnail: String
        let id: String
        let channel: String
        let url: String
    }
}

final class VideoListResponse: Decodable {
    let page: Int8
    let limit: Int8
    let total: Int8?
    let hasNext: Bool
    let items: [VideoItem]
}
