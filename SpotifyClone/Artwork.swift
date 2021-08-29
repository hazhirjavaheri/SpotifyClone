//
//  Artwork.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct Artwork: View {
    var offset: CGFloat
    
    var body: some View {
        VStack {
            Image("Playlist")
                .resizable()
                .scaledToFit()
                .padding(70)
                .offset(y: -70)
                .opacity(1 + Double(offset) / 200)
                .scaleEffect(1 + offset / 350, anchor: .top)
            Spacer()
        }
    }
}

struct Artwork_Previews: PreviewProvider {
    static var previews: some View {
        Artwork(offset: 0)
    }
}
