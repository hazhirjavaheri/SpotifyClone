//
//  PlayListItem.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct PlayListItem: View {
    @EnvironmentObject var playback: Playback
    @State private var isPresented = false

    var song: Song
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(song.name)
                    .font(.title)
                    .lineLimit(1)
                Text(song.artist)
                    .font(.headline)
            }
            Spacer()
            
            // Like Button
            Button(action: {
                playback.toggleFavorite(id: song.id)
            }, label: {
                Image(systemName:
                    song.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(song.isFavorite ? .green : .white)
                    .font(.title)
            })
            
            // Remove Button
            Button(action: {
                withAnimation {
                    playback.removeSong(id: song.id)
                }
            }, label: {
                Image(systemName: "minus.circle").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            })
            
            // Actions Sheet Button
            Button(action: {
                isPresented = true
            }, label: {
                Image(systemName: "ellipsis")
                    .font(.title)
            })
        }
        .padding(10)
        .background(Color.black)
        .foregroundColor(.white)
        .onTapGesture {
            playback.play(id: song.id)
        }
    }
}

struct PlayListItem_Previews: PreviewProvider {
    static var playback = Playback()
    
    static var previews: some View {
        PlayListItem(song: playback.playlist[1])
            .environmentObject(playback)
    }
}
