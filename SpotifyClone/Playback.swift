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
    
    // returns the index of a song in playlist by it's id
    func getIndex(id: UUID) -> Int? {
        return playlist.firstIndex(where: { $0.id == id })
    }
    
    // switches song being favorited to true or false by it's id
    func toggleFavorite(id: UUID) {
        guard let index = getIndex(id: id) else { return }
        playlist[index].isFavorite.toggle()
    }
    
    // removes a song with it's id from playlist
    func removeSong(id: UUID) {
        guard !playlist.isEmpty else {
            currentSongIndex = nil
            return
        }
        guard let index = getIndex(id: id) else { return }
        if index == currentSongIndex {
            pause()
            isPaused = false
            isPlaying = false
            currentSongIndex = nil
        }
        if let i = currentSongIndex, index < i {
            currentSongIndex = i - 1
        }
        playlist.remove(at: index)
    }
    
    // Changes the current song index in playlist
    func setCurrentSongIndex(index: Int) {
        if index == currentSongIndex { return }
        if index < playlist.count && index >= 0 {
            currentSongIndex = index
        } else {
            currentSongIndex = nil
        }
    }
    
    // initializes player with current song to be played, sets the duration
    func initPlayer() {
        guard let song = currentSong else { return }
        let sound = Bundle.main.path(forResource: song.name, ofType: "mp3")
        player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        player?.delegate = self.delegate
        self.duration = formatter.string(from: player?.duration ?? 0) ?? "0:00"
    }
    
    // starts playing the current song
    func play() {
        guard !playlist.isEmpty else { return }
        initPlayer()
        player?.play()
        isPlaying = true
        isPaused = false
        finished = false
    }
    
    // starts playing a song with given id
    func play(id: UUID) {
        guard let index = getIndex(id: id) else { return }
        if isPlaying && index == currentSongIndex { return }
        setCurrentSongIndex(index: index)
        play()
    }
    
    // pauses playback
    func pause() {
        player?.pause()
        isPlaying = false
        isPaused = true
    }
    
    // stops the playback
    func stop() {
        player?.stop()
        player = nil
        isPaused = false
        isPlaying = false
    }
    
    // starts playing the next song in the playlist
    func next() {
        guard let index = currentSongIndex else { return }
        stop()
        if index + 1 == playlist.count { return }
        setCurrentSongIndex(index: index + 1)
        play()
    }
    
    // starts playing the previous song in the playlist
    func previous() {
        guard let index = currentSongIndex else { return }
        if index == 0 { return }
        stop()
        setCurrentSongIndex(index: index - 1)
        play()
    }
    
    // toggles song being liked to true or false by index
    func likeSong(index: Int) {
        playList[index].isFavorite.toggle()
    }
}
