//
//  MiniPlayer.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct MiniPlayer: View {
    @EnvironmentObject var playback: Playback
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .cornerRadius(10)
                    .opacity(0.5)
                    .frame(height: 100)
                    .offset(y: -45)
                    .padding(.horizontal)
            }
            
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Image(playback.currentSong?.artwork ?? "Album")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text(playback.currentSong?.name ?? "").fontWeight(.heavy)
                                .lineLimit(2)
                            Text(playback.currentSong?.artist ?? "")
                                .lineLimit(1)
                        }
                        Spacer()
                        Button(action: {
                            if playback.isPlaying {
                                playback.pause()
                            } else {
                                playback.play()
                            }
                        }, label: {
                            Image(systemName: playback.isPlaying ? "pause.fill" : "play.fill")
                                .font(.title)
                                .padding()
                        })
                    }
                    .padding(10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isPresented = true
                    }
                    ProgressView(value: playback.progress)
                        .accentColor(.white)
                }
                .background(darkBlue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .offset(y: -50)
            }
            .padding(.horizontal)
            .shadow(color: .black, radius: 10)
            .fullScreenCover(isPresented: $isPresented) {
                Player(song: playback.currentSong!)
                    .environmentObject(playback)
            }
        }
    }
}

struct MiniPlayer_Previews: PreviewProvider {
    static let playback = Playback()
    
    static var previews: some View {
        MiniPlayer()
            .environmentObject(playback)
    }
}
