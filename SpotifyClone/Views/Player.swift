//
//  Player.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct Player: View {
    @EnvironmentObject var playback: Playback
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false
    var song: Song
    
    var body: some View {
        ZStack {
            // Black color background
            Color.black.ignoresSafeArea(.all)
            VStack {
                HStack {
                    // Dismiss the sheet
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.down")
                            .font(.title)
                    })
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Play List #1")
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                    
                    Spacer()
                    // Present Actions sheet
                    Button(action: {
                        if let _ = playback.currentSongIndex {
                            isPresented = true
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                            .font(.title)
                    })
                    .padding(.horizontal)
                }
                .padding(.top)
                
                // Song Artwork, Name and Artist
                Image(song.artwork)
                    .resizable()
                    .scaledToFit()
                    .padding(25)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(song.name)
                            .font(.title)
                            .bold()
                            .lineLimit(1)
                            .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        Text(song.artist)
                            .font(.system(size: 22))
                            .lineLimit(1)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // Progress, Current time and Duration
                Group {
                    ProgressView(value: playback.progress)
                        .padding(.horizontal)
                        .accentColor(.white)
                    HStack {
                        Text(playback.currentTime)
                        Spacer()
                        Text(playback.duration)
                    }
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                
                // Media Controls
                VStack {
                    HStack {
                        // Like button
                        Button(action: {
                            playback.toggleFavorite(id: song.id)
                        }, label: {
                            Image(systemName: song.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(song.isFavorite ? .green : .white)
                        })
                        .font(.title)
                        
                        Spacer()
                        
                        // Play Previous song
                        Button(action: {
                            playback.previous()
                        }, label: {
                            Image(systemName: "backward.end.fill")
                        })
                        .font(.largeTitle)
                        
                        Button(action: {
                            if playback.isPlaying {
                                playback.pause()
                            } else {
                                playback.play()
                            }
                        }, label: {
                            Image(systemName: playback.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        })
                        .font(.system(size: 65))
                        .padding(.horizontal)
                        
                        // Play Next song
                        Button(action: {
                            playback.next()
                        }, label: {
                            Image(systemName: "forward.end.fill")
                        })
                        .font(.largeTitle)
                        
                        Spacer()
                        
                        // Remove the song from playlist
                        Button(action: {
                            playback.removeSong(id: song.id)
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "minus.circle")
                                .font(.title)
                        })
                    }
                    HStack {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "hifispeaker")
                        })
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "square.and.arrow.up")
                        })
                    }
                    .font(.title)
                }
                .padding(.bottom, 40)
                .padding(.horizontal, 10)
                Spacer()
            }
            .foregroundColor(.white)
            .onAppear {
                guard !playback.isPlaying else { return }
                playback.initPlayer()
            }
        }
    }
}

struct Player_Previews: PreviewProvider {
    static let playback = Playback()
    
    static var previews: some View {
        Player(song: playback.playlist[1])
            .environmentObject(playback)
    }
}
