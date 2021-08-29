//
//  Playback.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import Foundation
import AVKit

class AVDelegate: NSObject, AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}

//  Playback class handles all actions related to playlist's songs.
//  It propagates any changes made to it's properties to views that use them.
final class Playback: ObservableObject {
    @Published var playlist: [Song] = playList
    @Published var isPlaylistLiked = false
    @Published var isPlaying = false
    @Published var currentSongIndex: Int? = 0
    @Published var currentTime: String
    @Published var duration: String
    @Published var progress: TimeInterval = 0.0
    @Published var finished = false
    
    private let formatter = DateComponentsFormatter()
    private var isPaused = false
    private var delegate = AVDelegate()
    private var player: AVAudioPlayer?
    
    var currentSong: Song? {
        if let index = currentSongIndex,
           index < playlist.count, index >= 0 {
            return playlist[index]
        } else {
            return nil
        }
    }
    
    init() {
        player?.delegate = delegate
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        duration = formatter.string(from: player?.duration ?? 0)!
        currentTime = formatter.string(from: player?.currentTime ?? 0)!
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] _ in
            if let player = player, isPlaying {
                currentTime = formatter.string(from: player.currentTime)!
                progress = player.currentTime / player.duration
            }
        }
    }
}