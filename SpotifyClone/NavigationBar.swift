//
//  NavigationBar.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct NavigationBar: View {
    @EnvironmentObject var playback: Playback
    var offset: CGFloat

    //  iPhone 11 Height = 896
    let height = UIScreen.main.bounds.size.height
    let ratio: CGFloat = UIScreen.main.bounds.size.height / 896
    let restOffset = UIScreen.main.bounds.size.height / 896 * 250
    let navBarHeight = UIScreen.main.bounds.size.height / 896 * 75
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer().frame(width: navBarHeight, height: navBarHeight)
                    Text("Play List #1")
                        .font(.title).bold()
                        .opacity(0)
                    Spacer()
                    Button(action: {
                        playback.isPlaylistLiked.toggle()
                    }, label: {
                        Image(systemName: playback.isPlaylistLiked ? "heart.fill" : "heart")
                            .foregroundColor(playback.isPlaylistLiked ? .green : .white)
                            .font(.title)
                    })
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis")
                            .font(.title)
                    })
                }
                .padding(25)
                .background(magenta)
                .opacity(op())
                .background(Color.clear)
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                    })
                    .foregroundColor(.white)
                    Spacer().frame(width: navBarHeight, height: navBarHeight)
                    
                    Spacer()
                }
                .padding(25)
                .edgesIgnoringSafeArea(.all)
                Spacer()
            }
        }
    }
    
    // Changes the amount of opacity of NavigationBar by value of offset
    // from zero to 1.0
    func op() -> Double {
        return offset > -restOffset ? 0 : -Double(offset + restOffset) / 100
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static let playback = Playback()

    static var previews: some View {
        NavigationBar(offset: -300)
            .environmentObject(playback)
    }
}
