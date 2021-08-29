//
//  Actions.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct Actions: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var playback: Playback
    var song: Song
    
    var body: some View {
        ZStack {
            // Black color background
            Color.black.ignoresSafeArea()
            ScrollView {
                Image(song.artwork)
                    .resizable()
                    .frame(width: 250, height: 250)
                Text(song.name)
                    .font(.title)
                    .lineLimit(2)
                Text(song.artist)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Group {
                        HStack {
                            // Like button
                            Button(action: {
                                playback.toggleFavorite(id: song.id)
                            }, label: {
                                Image(systemName:
                                        song.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(
                                        song.isFavorite ? .green : .white)
                                Text("Like")
                            })
                        }
                        HStack {
                            // Remove song from the playlist
                            Button(action: {
                                playback.removeSong(id: song.id)
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Label(
                                    title: { Text("Remove from this playlist") },
                                    icon: { Image(systemName: "minus.circle") })
                            })
                        }
                        HStack {
                            Image(systemName: "music.note.list")
                                .foregroundColor(.gray)
                            Text("Add to playlist")
                        }
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.gray)
                            Text("Share")
                        }
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.gray)
                            Text("View artist")
                        }
                        HStack {
                            Image(systemName: "person.2")
                                .foregroundColor(.gray)
                            Text("Song credits")
                        }
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.gray)
                            Text("Sleep timer")
                        }
                        Rectangle()
                            .frame(height: 100)
                            .foregroundColor(.clear)
                    }
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 20)
                }
            }
            .foregroundColor(.white)
            
            VStack {
                Spacer()
                // Close button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("close")
                        .font(.title2)
                })
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.black.ignoresSafeArea())
                .foregroundColor(.white)
                .shadow(color: .black, radius: 20, x: 0.0, y: -20)
            }
        }
    }
}

struct Actions_Previews: PreviewProvider {
    static let playback = Playback()
    
    static var previews: some View {
        Actions(song: playback.playlist[1])
            .environmentObject(playback)
    }
}
