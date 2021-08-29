//
//  PlayListPage.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct PlayListPage: View {
    @EnvironmentObject var playback: Playback
    @State var playButtonOffset: CGFloat = 0

    var body: some View {
        ZStack {
            //Background Layer
            LinearGradient(gradient: Gradient(colors: [magenta,.black]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            // Play List Artwork
            Artwork(offset: playButtonOffset)
                
            PlayListView(offset: $playButtonOffset)
            
            //Navigation Bar
            NavigationBar(offset: playButtonOffset)
            
            PlayButton(offset: playButtonOffset)
        }
    }
}

struct PlayListPage_Previews: PreviewProvider {
    static let playback = Playback()

    static var previews: some View {
        PlayListPage()
            .environmentObject(playback)
            .previewDevice("iPhone 11")
        PlayListPage()
            .environmentObject(playback)
            .previewDevice("iPhone 8")

    }
}
