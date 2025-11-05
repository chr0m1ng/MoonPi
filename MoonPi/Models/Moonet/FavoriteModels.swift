//
//  FavoriteModels.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

final class FavoriteAddRequest: Encodable {
    let url: String
    
    init(url: String) {
        self.url = url
    }
}
