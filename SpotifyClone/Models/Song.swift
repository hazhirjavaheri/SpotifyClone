//
//  Song.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import Foundation

struct Song: Identifiable {
    var id = UUID()
    var name: String
    var artist: String
    var artwork: String
    var isFavorite: Bool
}
