//
//  PlayButton.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct PlayButton: View {
    @EnvironmentObject var playback: Playback
    let height: CGFloat = UIScreen.main.bounds.size.height
    let ratio: CGFloat = UIScreen.main.bounds.size.height / 896
    let initialButtonOffset: CGFloat = 330
    var offset: CGFloat

    var body: some View {
        VStack {
            Spacer()
                .frame(height:  offset + initialButtonOffset * ratio)
            Text("Play List #1")
                .font(.title)
                .foregroundColor(.white)
            Button(action: {
                if playback.isPlaying {
                    playback.pause()
                } else {
                    playback.play()
                }
            }) {
                Text(playback.isPlaying ? "PAUSE" : "PLAY")
                    .frame(width: 120, height: 50)
                    .foregroundColor(.white)
                    .background(green)
                    .cornerRadius(25)
                    .font(.system(size: 16, weight: .bold))
                    .shadow(radius: 20)
            }
            .padding(8 * ratio)
            Spacer()
        }
    }
}


struct PlayButton_Previews: PreviewProvider {
    static let playback = Playback()
    
    static var previews: some View {
        PlayButton(offset: 0)
            .environmentObject(playback)
    }
}
