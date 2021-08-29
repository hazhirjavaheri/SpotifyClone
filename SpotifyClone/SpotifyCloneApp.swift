//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

@main
struct SpotifyCloneApp: App {
    @StateObject private var playback = Playback()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(playback)
        }
    }
}
